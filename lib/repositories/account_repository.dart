import 'package:ddnc_new/api/response/sign_in_response.dart';
import 'package:ddnc_new/di/socket_manager.dart';
import 'package:ddnc_new/ui/data/account.dart';
import 'package:ddnc_new/ui/data/app_configs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../api/api_response.dart';
import '../api/api_service.dart';
import '../api/request/sign_in_request.dart';
import '../api/response/resource.dart';
import '../commons/shared_preferences_helpers.dart';
import '../models/user_model.dart';

class AccountRepository {
  final ApiService _apiService;
  final AppConfigs _appConfigs;
  final AccountInfo _account;
  late SharedPreferencesHelpers _preferencesHelpers;

  AccountRepository({
    required ApiService apiService,
    required AccountInfo account,
    required AppConfigs appConfigs,
  })  : _apiService = apiService,
        _appConfigs = appConfigs,
        _account = account {
    SharedPreferencesHelpers.getInstance()
        .then((instance) => _preferencesHelpers = instance);
  }

  static AccountRepository of(BuildContext context) =>
      Provider.of(context, listen: false);

  Future<Resource<String>> signIn(String accessToken, String type) async {
    try {
      var request = SignInRequest(accessToken, type);
      var apiResource = ApiResponse.create<dynamic>(
          await _apiService.signIn(signInRequest: request));
      // return apiResource;

      if (apiResource is ApiSuccessResponse) {
        await Future.wait([
          _preferencesHelpers.saveToDisk(SharedPreferencesHelpers.tokenKey,
              apiResource.body?.accessToken ?? ""),
          _preferencesHelpers.saveToDisk(SharedPreferencesHelpers.userIdKey,
              apiResource.body?.userInfo.id ?? ""),
          _preferencesHelpers.saveToDisk(
              SharedPreferencesHelpers.roleKey, apiResource.body?.role ?? ""),
        ]);

        SocketManager().socket.emit('login', apiResource.body?.userInfo.id);

        SignInResponse info = await apiResource.body;
        var userModel = await UserModel(
          info.userInfo.id.toString(),
          info.userInfo.code,
          info.userInfo.name,
          info.userInfo.email,
          info.role,
          info.userInfo.picture,
          info.accessToken,
        );
        _account.accountInfo = userModel;
        return Resource.success("");
      } else if (apiResource is ApiEmptyResponse) {
        _preferencesHelpers.clearSignInInfo();
        return Resource.error("", apiResource.statusCode);
      } else {
        _preferencesHelpers.clearSignInInfo();
        return Resource.error(apiResource.errorMessage, apiResource.statusCode);
      }
    } catch (e, s) {
      _preferencesHelpers.clearSignInInfo();
      var apiErrorResource = ApiResponse.error(e);
      return Resource.error(
          apiErrorResource.errorMessage, apiErrorResource.statusCode);
    }
  }

  Future<Resource<String>> signOut() async {
    try {
      _preferencesHelpers.clearSignInInfo();
      await GoogleSignIn().signOut();
      await GoogleSignIn().disconnect();

      return Resource.success("Sign out successfully");
    } catch (e, s) {
      var apiErrorResource = ApiResponse.error(e);
      return Resource.error(
          apiErrorResource.errorMessage, apiErrorResource.statusCode);
    }
  }

  Future<String> getRole() async {
    try {
      String role = await _preferencesHelpers
          .getFromDisk(SharedPreferencesHelpers.roleKey);

      return role;
    } catch (e, s) {
      return "";
    }
  }
}
