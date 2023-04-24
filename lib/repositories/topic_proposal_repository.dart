import 'package:ddnc_new/api/api_response.dart';
import 'package:ddnc_new/api/api_service.dart';
import 'package:ddnc_new/api/request/update_topic_proposal_request.dart';
import 'package:ddnc_new/api/response/common_success_response.dart';
import 'package:ddnc_new/api/response/list_schedule_response.dart';
import 'package:ddnc_new/api/response/list_topic_proposal_response.dart';
import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/ui/data/account.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class TopicProposalRepository {
  final ApiService _apiService;
  final AccountInfo _accountInfo;

  TopicProposalRepository({
    required ApiService apiService,
    required AccountInfo accountInfo,
  })  : _apiService = apiService,
        _accountInfo = accountInfo;

  static TopicProposalRepository of(BuildContext context) =>
      Provider.of<TopicProposalRepository>(context, listen: false);

  Future<Resource<ListTopicProposalResponse>> listTopicProposal(
    String search,
    int? scheduleId,
    String? is_created,
    String? is_lecturer, [
    int page = 1,
    int itemPerPage = Constants.itemPerPage,
  ]) async {
    try {
      var apiResource = ApiResponse.create<ListTopicProposalResponse>(
          await _apiService.listTopicProposal(
        search: search,
        scheduleId: scheduleId,
        is_created: is_created,
        is_lecturer: is_lecturer,
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

  Future<Resource<String>> createTopicProposal({
    required UpdateTopicProposalRequest request,
  }) async {
    try {
      var apiResource = ApiResponse.create<CommonSuccessResponse>(
          await _apiService.createTopicProposal(
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

  Future<Resource<String>> updateTopicProposal({
    required int topicId,
    required UpdateTopicProposalRequest request,
  }) async {
    try {
      var apiResource = ApiResponse.create<CommonSuccessResponse>(
          await _apiService.updateTopicProposal(
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

  Future<Resource<String>> deleteTopicProposal({
    required int topicId,
  }) async {
    try {
      var apiResource = ApiResponse.create<CommonSuccessResponse>(
          await _apiService.deleteTopicProposal(
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

  Future<Resource<String>> lecturerApproveProposal({
    required int topicId,
  }) async {
    try {
      var apiResource = ApiResponse.create<CommonSuccessResponse>(
          await _apiService.lecturerApproveProposal(
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

  Future<Resource<String>> lecturerDeclineProposal({
    required int topicId,
  }) async {
    try {
      var apiResource = ApiResponse.create<CommonSuccessResponse>(
          await _apiService.lecturerDeclineProposal(
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
          await _apiService.listSchedule(search: "", page: 1, limit: 9999));

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
