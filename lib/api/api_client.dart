import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:logging/logging.dart' as logging;
import 'package:provider/provider.dart';

import 'header_interceptor.dart';
import 'json_to_type_converter.dart';
import 'response/sign_in_response.dart';

class ApiClient extends ChopperClient {
  ApiClient()
      : super(
    baseUrl: Uri.parse("http://10.0.2.2:8001"),
    interceptors: [HeaderInterceptor(), HttpLoggingInterceptor()],
    converter: const JsonToTypeConverter({
      SignInResponse: SignInResponse.fromJson,
      ListUserResponse: ListUserResponse.fromJson,
      ListTopicResponse: ListTopicResponse.fromJson,
    }),
  ) {
    if (kDebugMode) {
      Logger.root.level = logging.Level.ALL;
      Logger.root.onRecord.listen((rec) {
        log('${rec.level.name}: ${rec.time}: ${rec.message}');
      });
    }
  }

  static ApiClient of(BuildContext context) =>
      Provider.of<ApiClient>(context, listen: false);
}
