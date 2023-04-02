import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';

import './response/error.dart';

abstract class ApiResponse<T> {
  static const int codeUnknown = 0;
  static const int codeNetworkNotAvailable = 1;
  static const int codeInvalidUrl = 2;
  static const int codeInvalidFormatResponse = 3;
  static const int codeCannotConnectServer = 4;

  final T? body;
  final int statusCode;
  final String errorMessage;

  ApiResponse(
      {this.body, required this.statusCode, required this.errorMessage});

  static ApiResponse<T> create<T>(Response<T> response) {
    if (response.isSuccessful) {
      var body = response.body;
      if (body == null || response.statusCode == HttpStatus.noContent) {
        return ApiEmptyResponse<T>();
      } else {
        return ApiSuccessResponse<T>(body: body);
      }
    } else {
      try {
        var error = Error.fromJson(jsonDecode(response.bodyString));
        return ApiErrorResponse<T>(
            statusCode: response.statusCode,
            errorMessage: error.message.message);
      } catch (e) {
        return ApiErrorResponse<T>(
            statusCode: response.statusCode, errorMessage: "");
      }
    }
  }

  static ApiErrorResponse<T> error<T>(dynamic e) {
    if (e is SocketException) {
      switch (e.osError?.errorCode) {
        case 111:
          return ApiErrorResponse<T>(
              statusCode: codeCannotConnectServer, errorMessage: "");
        case 7:
        default:
          return ApiErrorResponse<T>(
              statusCode: codeNetworkNotAvailable, errorMessage: "");
      }
    } else if (e is TypeError) {
      return ApiErrorResponse<T>(
          statusCode: codeInvalidFormatResponse, errorMessage: "");
    } else {
      return ApiErrorResponse<T>(
          statusCode: codeUnknown, errorMessage: e.toString());
    }
  }
}

class ApiSuccessResponse<T> extends ApiResponse<T> {
  ApiSuccessResponse({required body})
      : super(
          body: body,
          errorMessage: "",
          statusCode: HttpStatus.accepted,
        );
}

class ApiEmptyResponse<T> extends ApiResponse<T> {
  ApiEmptyResponse()
      : super(
          body: null,
          statusCode: HttpStatus.noContent,
          errorMessage: "",
        );
}

class ApiErrorResponse<T> extends ApiResponse<T> {
  ApiErrorResponse({
    required statusCode,
    errorMessage,
  }) : super(
          body: null,
          statusCode: statusCode,
          errorMessage: errorMessage,
        );
}
