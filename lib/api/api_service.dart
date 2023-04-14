import 'package:chopper/chopper.dart';
import 'package:ddnc_new/api/request/sign_in_request.dart';
import 'package:ddnc_new/api/request/update_committee_request.dart';
import 'package:ddnc_new/api/request/update_schedule_request.dart';
import 'package:ddnc_new/api/request/update_topic_request.dart';
import 'package:ddnc_new/api/request/update_user_request.dart';
import 'package:ddnc_new/api/response/common_success_response.dart';
import 'package:ddnc_new/api/response/list_committee_response.dart';
import 'package:ddnc_new/api/response/list_schedule_response.dart';
import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../commons/constants.dart';
import 'header_interceptor.dart';
import 'response/sign_in_response.dart';

part 'api_service.chopper.dart';

@ChopperApi(baseUrl: '/api')
abstract class ApiService extends ChopperService {
  // static ApiService create() {
  //   final client = ChopperClient(
  //       baseUrl: Uri.parse("http://10.0.2.2:8001"),
  //       services: [_$ApiService()],
  //       converter: JsonConverter(),
  //       interceptors: [HeaderInterceptor()]);
  //   return _$ApiService(client);
  // }

  static ApiService create({ChopperClient? client}) => _$ApiService(client);

  static ApiService of(BuildContext context) =>
      Provider.of<ApiService>(context, listen: false);

  @Get(path: 'v2/test')
  Future<Response<dynamic>> testApi(@body dynamic request);

  @Post(path: 'v2/auth/login')
  Future<Response<SignInResponse>> signIn({
    @Header(HeaderInterceptor.requestNoAuth)
        String noAuth = HeaderInterceptor.requestNoAuth,
    @Body() required SignInRequest signInRequest,
  });

  @Get(path: 'v2/user')
  Future<Response<ListUserResponse>> listUser({
    @Query("search") required String search,
    @Query("type") required String type,
    @Query("limit") int limit = Constants.itemPerPage,
    @Query("page") required int page,
  });

  @Put(path: 'v2/user/{userId}')
  Future<Response<CommonSuccessResponse>> updateUser({
    @Path("userId") required int userId,
    @Body() required UpdateUserRequest request,
  });

  @Get(path: 'v2/topic')
  Future<Response<ListTopicResponse>> listTopic({
    @Query("search") required String search,
    @Query("page") required int page,
    @Query("limit") int limit = Constants.itemPerPage,
  });

  @Put(path: 'v2/topic/{topicId}')
  Future<Response<CommonSuccessResponse>> updateTopic({
    @Path("topicId") required int topicId,
    @Body() required UpdateTopicRequest request,
  });

  @Get(path: 'v2/schedule')
  Future<Response<ListScheduleResponse>> listSchedule({
    @Query("search") required String search,
    @Query("limit") int limit = Constants.itemPerPage,
    @Query("page") required int page,
  });

  @Post(path: 'v2/schedule')
  Future<Response<CommonSuccessResponse>> createSchedule({
    @Body() required UpdateScheduleRequest request,
  });

  @Put(path: 'v2/schedule/{scheduleId}')
  Future<Response<CommonSuccessResponse>> updateSchedule({
    @Path("scheduleId") required int scheduleId,
    @Body() required UpdateScheduleRequest request,
  });

  @Delete(path: 'v2/schedule/{scheduleId}')
  Future<Response<CommonSuccessResponse>> deleteSchedule({
    @Path("scheduleId") required int scheduleId,
  });

  @Get(path: 'v2/committee')
  Future<Response<ListCommitteeResponse>> listCommittee({
    @Query("search") required String search,
    @Query("limit") int limit = Constants.itemPerPage,
    @Query("page") required int page,
  });

  @Post(path: 'v2/committee')
  Future<Response<CommonSuccessResponse>> createCommittee({
    @Body() required UpdateCommitteeRequest request,
  });

  @Put(path: 'v2/committee/{committeeId}')
  Future<Response<CommonSuccessResponse>> updateCommittee({
    @Path("committeeId") required int committeeId,
    @Body() required UpdateCommitteeRequest request,
  });

  @Delete(path: 'v2/committee/{committeeId}')
  Future<Response<CommonSuccessResponse>> deleteCommittee({
    @Path("committeeId") required int committeeId,
  });
}
