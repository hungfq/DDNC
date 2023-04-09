import 'package:ddnc_new/api/api_response.dart';
import 'package:ddnc_new/api/api_service.dart';
import 'package:ddnc_new/api/request/update_schedule_request.dart';
import 'package:ddnc_new/api/response/common_success_response.dart';
import 'package:ddnc_new/api/response/list_schedule_response.dart';
import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/ui/data/account.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ScheduleRepository {
  final ApiService _apiService;
  final AccountInfo _accountInfo;

  ScheduleRepository({
    required ApiService apiService,
    required AccountInfo accountInfo,
  })  : _apiService = apiService,
        _accountInfo = accountInfo;

  static ScheduleRepository of(BuildContext context) =>
      Provider.of<ScheduleRepository>(context, listen: false);

  Future<Resource<ListScheduleResponse>> listSchedule(
    String search, [
    int page = 1,
    int itemPerPage = Constants.itemPerPage,
  ]) async {
    try {
      var apiResource = ApiResponse.create<ListScheduleResponse>(
          await _apiService.listSchedule(
        search: search,
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

  Future<Resource<String>> createSchedule({
    required UpdateScheduleRequest request,
  }) async {
    try {
      var apiResource = ApiResponse.create<CommonSuccessResponse>(
          await _apiService.createSchedule(
        request: request,
      ));

      if (apiResource is ApiSuccessResponse) {
        return Resource.success(apiResource.body!.message);
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

  Future<Resource<String>> updateSchedule({
    required int scheduleId,
    required UpdateScheduleRequest request,
  }) async {
    try {
      var apiResource = ApiResponse.create<CommonSuccessResponse>(
          await _apiService.updateSchedule(
        request: request,
        scheduleId: scheduleId,
      ));

      if (apiResource is ApiSuccessResponse) {
        return Resource.success(apiResource.body!.message);
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

  Future<Resource<String>> deleteSchedule({
    required int scheduleId,
  }) async {
    try {
      var apiResource = ApiResponse.create<CommonSuccessResponse>(
          await _apiService.deleteSchedule(
        scheduleId: scheduleId,
      ));

      if (apiResource is ApiSuccessResponse) {
        return Resource.success(apiResource.body!.message);
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

  Future<Resource<List<UserInfo>>> getUsers(
    String search,
    String type,
  ) async {
    try {
      var apiResource = ApiResponse.create<ListUserResponse>(await _apiService
          .listUser(search: search, type: type, page: 1, limit: 9999));

      if (apiResource is ApiSuccessResponse) {
        return Resource.success(apiResource.body!.data);
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
