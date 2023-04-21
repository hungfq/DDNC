import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/ui/components/primary_outlined_button.dart';
import 'package:ddnc_new/ui/components/primary_text_view.dart';
import 'package:ddnc_new/ui/components/system_padding.dart';
import 'package:ddnc_new/ui/resources/app_transitions.dart';
import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessDialog {
  static bool isShowing = false;

  static void show(
      {required BuildContext context, String? msg, Function? callback}) {
    if (isShowing) return;
    isShowing = true;
    showGeneralDialog(
      barrierDismissible: false,
      transitionDuration:
          const Duration(milliseconds: Constants.animationDuration),
      transitionBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return AppTransitions.fadeTransition(child, animation);
      },
      useRootNavigator: false,
      context: context,
      pageBuilder: (_, __, ___) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: SuccessDialogView(
            errorMessage: msg ?? "",
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

class SuccessDialogView extends StatefulWidget {
  final String? errorMessage;
  final Function? callback;

  const SuccessDialogView({Key? key, this.errorMessage, this.callback})
      : super(key: key);

  @override
  _SuccessDialogViewState createState() => _SuccessDialogViewState();
}

class _SuccessDialogViewState extends State<SuccessDialogView> {
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
                padding: const EdgeInsets.only(
                    top: Dimens.marginPaddingSizeXXMini),
                child: Icon(
                  CupertinoIcons.checkmark_alt_circle_fill,
                  size: Dimens.commonDialogIconSize,
                  color: theme.colorScheme.primary,
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
                  labelText: "Close",
                  heightWrap: true,
                  widthWrap: false,
                  backgroundColor: theme.primaryColor,
                  onClick: () {
                    SuccessDialog.hide(context);
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
