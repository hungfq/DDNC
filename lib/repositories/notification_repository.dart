import 'package:ddnc_new/api/api_response.dart';
import 'package:ddnc_new/api/api_service.dart';
import 'package:ddnc_new/api/response/common_success_response.dart';
import 'package:ddnc_new/api/response/list_notification_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/ui/data/account.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class NotificationRepository {
  final ApiService _apiService;
  final AccountInfo _accountInfo;

  NotificationRepository({
    required ApiService apiService,
    required AccountInfo accountInfo,
  })  : _apiService = apiService,
        _accountInfo = accountInfo;

  static NotificationRepository of(BuildContext context) =>
      Provider.of<NotificationRepository>(context, listen: false);

  Future<Resource<ListNotificationResponse>> listNotification([
    int page = 1,
    int itemPerPage = Constants.itemPerPage,
  ]) async {
    try {
      var apiResource = ApiResponse.create<ListNotificationResponse>(
          await _apiService.listNotification(
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

  Future<Resource<String>> readNotification({
    required int notificationId,
  }) async {
    try {
      var apiResource = ApiResponse.create<CommonSuccessResponse>(
          await _apiService.readNotification(
        notificationId: notificationId,
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

  Future<Resource<String>> deleteNotification({
    required int notificationId,
  }) async {
    try {
      var apiResource = ApiResponse.create<CommonSuccessResponse>(
          await _apiService.deleteNotification(
        notificationId: notificationId,
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
}
