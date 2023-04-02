import 'dart:convert';
import 'dart:io';

import 'package:ddnc_new/api/response/sign_in_response.dart';
import 'package:ddnc_new/ui/data/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../api/api_response.dart';
import '../api/api_service.dart';
import '../api/request/sign_in_request.dart';
import '../api/response/resource.dart';
import '../commons/shared_preferences_helpers.dart';
import '../models/user_model.dart';

class AccountRepository {
  final ApiService _apiService;
  final AccountInfo _account;
  late SharedPreferencesHelpers _preferencesHelpers;

  AccountRepository({
    required ApiService apiService,
    required AccountInfo account,
  })  : _apiService = apiService,
        _account = account {
    SharedPreferencesHelpers.getInstance()
        .then((instance) => _preferencesHelpers = instance);
  }

  static AccountRepository of(BuildContext context) =>
      Provider.of(context, listen: false);

  Future<Object> signIn(String accessToken, String type) async {
    try {
      var request = SignInRequest(accessToken, type);
      var apiResource = ApiResponse.create<dynamic>(
          await _apiService.signIn(signInRequest: request));
      // return apiResource;

      if (apiResource is ApiSuccessResponse) {
        await Future.wait([
          _preferencesHelpers.saveToDisk(
              SharedPreferencesHelpers.tokenKey, apiResource.body?.accessToken ?? ""),
        ]);

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
}
