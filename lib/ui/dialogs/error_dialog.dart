import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/helpers.dart';
import 'package:ddnc_new/ui/components/primary_outlined_button.dart';
import 'package:ddnc_new/ui/components/primary_text_view.dart';
import 'package:ddnc_new/ui/components/system_padding.dart';
import 'package:ddnc_new/ui/resources/app_transitions.dart';
import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/material.dart';

class ErrorDialog {
  static bool isShowing = false;

  static void show(
      {required BuildContext context,
      String? msg,
      int? statusCode,
      String? buttonLabel,
      Function? callback}) {
    if (isShowing) return;
    isShowing = true;

    String errorMessage =
        Helpers.parseResponseError(statusCode: statusCode, errorMessage: msg);

    showGeneralDialog(
      barrierDismissible: false,
      transitionDuration:
          const Duration(milliseconds: Constants.animationDuration),
      useRootNavigator: false,
      transitionBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return AppTransitions.fadeTransition(child, animation);
      },
      context: context,
      pageBuilder: (_, __, ___) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: ErrorDialogView(
            buttonLabel: buttonLabel,
            errorMessage: errorMessage,
            callback: callback,
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    isShowing = false;
    Navigator.of(context, rootNavigator: false).pop();
  }
}

class ErrorDialogView extends StatefulWidget {
  final String? errorMessage;
  final Function? callback;
  final String? buttonLabel;

  const ErrorDialogView(
      {Key? key, this.errorMessage, this.callback, this.buttonLabel})
      : super(key: key);

  @override
  _ErrorDialogViewState createState() => _ErrorDialogViewState();
}

class _ErrorDialogViewState extends State<ErrorDialogView> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SystemPadding(
      child: Center(
        child: Card(
          margin: const EdgeInsets.all(Dimens.marginPaddingSizeXXMini),
          color: theme.colorScheme.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.largeComponentRadius),
            ),
          ),
          elevation: 0,
          child: Wrap(
            children: [
              Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.only(top: Dimens.marginPaddingSizeXXMini),
                child: const Icon(
                  Icons.warning_rounded,
                  size: Dimens.commonDialogIconSize,
                  color: Colors.red,
                ),
              ),
              Material(
                color: theme.colorScheme.surface,
                child: Container(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      Dimens.marginPaddingSizeXXXMini,
                      Dimens.marginPaddingSizeXXMini,
                      Dimens.marginPaddingSizeXXXMini,
                      0),
                  width: double.infinity,
                  child: PrimaryTextView(
                    widget.errorMessage ?? "",
                    textAlign: TextAlign.center,
                    maxLines: 5,
                    isBold: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimens.marginPaddingSizeXXMini),
                child: PrimaryOutlinedButton(
                  labelText: widget.buttonLabel ?? "Close",
                  heightWrap: true,
                  widthWrap: false,
                  backgroundColor: Colors.red,
                  onClick: () {
                    ErrorDialog.hide(context);
                    widget.callback?.call();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
