import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/ui/data/account.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../api/api_response.dart';
import '../api/api_service.dart';
import '../api/response/resource.dart';
import '../commons/constants.dart';

class UserRepository {
  final ApiService _apiService;
  final AccountInfo _accountInfo;

  UserRepository({
    required ApiService apiService,
    required AccountInfo accountInfo,
  })  : _apiService = apiService,
        _accountInfo = accountInfo;

  static UserRepository of(BuildContext context) =>
      Provider.of<UserRepository>(context, listen: false);

  Future<Resource<ListUserResponse>> listUser([
    int page = 1,
    int itemPerPage = Constants.itemPerPage,
  ]) async {
    try {
      var apiResource =
          ApiResponse.create<ListUserResponse>(await _apiService.listUser(
        page: page,
        limit: itemPerPage,
      ));

      if (apiResource is ApiSuccessResponse) {
        return Resource.success(apiResource.body!);
      } else if (apiResource is ApiEmptyResponse) {
        return Resource.error("", apiResource.statusCode);
      } else {
        return Resource.error(apiResource.errorMessage, apiResource.statusCode);
      }
    } catch (e, s) {
      var apiErrorResource = ApiResponse.error(e);
      return Resource.error(
          apiErrorResource.errorMessage, apiErrorResource.statusCode);
    }
  }
}
