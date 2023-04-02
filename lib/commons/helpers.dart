import 'dart:io';

import 'package:ddnc_new/api/api_response.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class Helpers {
  static String parseResponseError({int? statusCode, String? errorMessage}) {
    String message = "";
    if (errorMessage == null || errorMessage.isEmpty) {
      switch (statusCode) {
        case ApiResponse.codeUnknown:
          message = "Unknown error";
          break;
        case ApiResponse.codeNetworkNotAvailable:
          message = "Please check your connection again";
          break;
        case ApiResponse.codeInvalidUrl:
          message = "Please check your URL again";
          break;
        case ApiResponse.codeInvalidFormatResponse:
          message = "The data from the server is the wrong format";
          break;
        case ApiResponse.codeCannotConnectServer:
          message = "Cannot connect to server";
          break;
        case HttpStatus.notFound:
          message = "The url is not existed";
          break;
      }
    } else {
      message = errorMessage;
    }

    return message;
  }

  static void fieldNextFocus(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void showSnackBar(
      {@required ScaffoldState? scaffoldKey, String? message}) {
    ScaffoldMessenger.of(scaffoldKey!.context).showSnackBar(SnackBar(
      content: Text(message ?? ""),
      duration: const Duration(milliseconds: Constants.snackBarDuration),
    ));
  }
}
