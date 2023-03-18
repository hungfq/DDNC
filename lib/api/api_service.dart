import 'package:chopper/chopper.dart';

part 'api_service.chopper.dart';

@ChopperApi(baseUrl: '/api')
abstract class ApiService extends ChopperService {

  static ApiService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse("127.0.0.1"),
      services: [_$ApiService()],
      converter: JsonConverter(),
    );
    return _$ApiService(client);
  }

  @Post(path: '/endpoint')
  Future<Response<dynamic>> postData(@Body() Map<String, dynamic> data);


  @Post(path: 'v2/auth/login')
  Future<Response<dynamic>> signIn({
    @Field('access_token') required String? accessToken,
    @Field('type') required String? type,
  });
}
