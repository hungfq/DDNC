import 'package:ddnc_new/api/api_response.dart';
import 'package:ddnc_new/api/api_service.dart';
import 'package:ddnc_new/api/request/update_topic_request.dart';
import 'package:ddnc_new/api/response/common_success_response.dart';
import 'package:ddnc_new/api/response/list_schedule_response.dart';
import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/ui/data/account.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class TopicRepository {
  final ApiService _apiService;
  final AccountInfo _accountInfo;

  TopicRepository({
    required ApiService apiService,
    required AccountInfo accountInfo,
  })  : _apiService = apiService,
        _accountInfo = accountInfo;

  static TopicRepository of(BuildContext context) =>
      Provider.of<TopicRepository>(context, listen: false);

  Future<Resource<ListTopicResponse>> listTopic([
    int page = 1,
    int itemPerPage = Constants.itemPerPage,
  ]) async {
    try {
      var apiResource =
          ApiResponse.create<ListTopicResponse>(await _apiService.listTopic(
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

  Future<Resource<String>> updateTopic({
    required int topicId,
    required UpdateTopicRequest request,
  }) async {
    try {
      var apiResource = ApiResponse.create<CommonSuccessResponse>(
          await _apiService.updateTopic(
        request: request,
        topicId: topicId,
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

  Future<Resource<List<ScheduleInfo>>> getSchedules() async {
    try {
      var apiResource = ApiResponse.create<ListScheduleResponse>(
          await _apiService.listSchedule(page: 1, limit: 9999));

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
