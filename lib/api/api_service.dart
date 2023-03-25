import 'package:chopper/chopper.dart';

part 'api_service.chopper.dart';

@ChopperApi(baseUrl: '/api')
abstract class ApiService extends ChopperService {
  static ApiService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse("http://10.0.2.2:8001"),
      services: [_$ApiService()],
      converter: JsonConverter(),
    );
    return _$ApiService(client);
  }

  @Get(path: 'v2/test')
  Future<Response<dynamic>> testApi(@body dynamic request);

  @Post(path: 'v2/auth/login')
  Future<Response<dynamic>> signIn(@body dynamic request);
}
