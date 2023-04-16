import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/ui/components/primary_filled_button.dart';
import 'package:ddnc_new/ui/components/primary_outlined_button.dart';
import 'package:ddnc_new/ui/components/primary_text_view.dart';
import 'package:ddnc_new/ui/components/system_padding.dart';
import 'package:ddnc_new/ui/resources/app_transitions.dart';
import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmDialog {
  static Future show(
      {required BuildContext context,
      required String question,
      String? labelPositiveButton,
      String? labelNegativeButton,
      Function()? positiveCallback,
      Function()? negativeCallback}) {
    return showGeneralDialog(
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
          child: _ConfirmDialogView(
            question: question,
            labelNegativeButton: labelNegativeButton,
            labelPositiveButton: labelPositiveButton,
            negativeCallback: negativeCallback,
            positiveCallback: positiveCallback,
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: false).pop();
  }
}

class _ConfirmDialogView extends StatefulWidget {
  final String question;
  final String? labelPositiveButton;
  final String? labelNegativeButton;
  final Function? positiveCallback;
  final Function? negativeCallback;

  const _ConfirmDialogView(
      {Key? key,
      required this.question,
      this.positiveCallback,
      this.negativeCallback,
      this.labelPositiveButton,
      this.labelNegativeButton})
      : super(key: key);

  @override
  _ConfirmDialogViewState createState() => _ConfirmDialogViewState();
}

class _ConfirmDialogViewState extends State<_ConfirmDialogView> {

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
                padding: const EdgeInsets.only(top: Dimens.marginPaddingSizeXXMini),
                child: Icon(
                  CupertinoIcons.question_circle_fill,
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
                    widget.question,
                    textAlign: TextAlign.center,
                    maxLines: 5,
                    isBold: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimens.marginPaddingSizeXXMini),
                child: Row(
                  children: [
                    Expanded(
                      child: PrimaryOutlinedButton(
                        labelText: widget.labelNegativeButton ?? "No",
                        heightWrap: true,
                        backgroundColor: Colors.red,
                        onClick: () {
                          var negativeCallback = widget.negativeCallback;
                          if (negativeCallback == null) {
                            Navigator.of(context).pop(false);
                          } else {
                            ConfirmDialog.hide(context);
                            widget.negativeCallback?.call();
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: Dimens.marginPaddingSizeXXMini),
                    Expanded(
                      child: PrimaryFilledButton(
                        labelText: widget.labelPositiveButton ?? "Yes",
                        heightWrap: true,
                        onClick: () {
                          var positiveCallback = widget.positiveCallback;
                          if (positiveCallback == null) {
                            return Navigator.of(context).pop(true);
                          } else {
                            ConfirmDialog.hide(context);
                            widget.positiveCallback?.call();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
