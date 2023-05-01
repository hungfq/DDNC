import 'dart:io';

import 'package:ddnc_new/api/api_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/ui/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'app_page.dart';
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

  static void showErrorDialog({
    required BuildContext context,
    required Resource resource,
  }) {
    ErrorDialog.show(
      context: context,
      statusCode: resource.statusCode,
      msg: resource.message,
    );
  }

  static void showSnackBar(
      {@required ScaffoldState? scaffoldKey, String? message}) {
    ScaffoldMessenger.of(scaffoldKey!.context).showSnackBar(SnackBar(
      content: Text(message ?? ""),
      duration: const Duration(milliseconds: Constants.snackBarDuration),
    ));
  }

  static void reSignIn(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pushNamed(
      AppPages.signInPage,
    ).then((result) async {
      if (result != null) {
        // accountInfo.accountInfo = accountInfo as AccountInfo;
        // String? deviceToken = await FirebaseMessaging.instance.getToken();
        // configurationBloc.updateDeviceId(deviceToken ?? "");
        // callingBloc.updatePushKitToken(null);
      }
    });
  }
}
