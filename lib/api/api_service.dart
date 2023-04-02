import 'package:chopper/chopper.dart';
import 'package:ddnc_new/api/request/list_user_request.dart';
import 'package:ddnc_new/api/request/sign_in_request.dart';
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
    @Query("page") required int page,
    @Query("limit") int limit = Constants.itemPerPage,
  });
}
