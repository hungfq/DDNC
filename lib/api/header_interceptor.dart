import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:ddnc_new/commons/extensions.dart';

import '../commons/shared_preferences_helpers.dart';

class HeaderInterceptor extends RequestInterceptor {
  static const String authHeader = "Authorization";
  static const String bearer = "Bearer ";
  static const String requestNoAuth = "@NoAuth";

  @override
  FutureOr<Request> onRequest(Request request) async {
    if (request.headers.containsKey(requestNoAuth)) {
      request.headers.remove(requestNoAuth);
      return request;
    } else {
      SharedPreferencesHelpers sharedPreferences =
          await SharedPreferencesHelpers.getInstance();
      String? token =
          sharedPreferences.getFromDisk(SharedPreferencesHelpers.tokenKey);

      if (!token.isNullOrEmpty()) {
        return request.copyWith(headers: {authHeader: bearer + token!});
      } else {
        return request;
      }
    }
  }
}
