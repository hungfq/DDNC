import 'package:ddnc_new/commons/constants.dart';
import 'package:flutter/material.dart';

import '../components/primary_text_view.dart';
import '../resources/dimens.dart';

class LoadingDialog {
  static bool isShowing = false;

  static void show(BuildContext context, [String? message]) {
    if (isShowing) return;
    isShowing = true;
    showGeneralDialog(
      barrierDismissible: false,
      transitionDuration:
          const Duration(milliseconds: Constants.animationDuration),
      useRootNavigator: false,
      context: context,
      pageBuilder: (_, __, ___) {
        var _theme = Theme.of(context);
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.marginPaddingSizeXXMini,
                vertical: Dimens.marginPaddingSizeXXXMini,
              ),
              decoration: BoxDecoration(
                color: _theme.backgroundColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(Dimens.mediumComponentRadius),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: Dimens.marginPaddingSizeXMini),
                  PrimaryTextView(
                    message ?? "${"Processing"}...",
                    style: _theme.textTheme.subtitle2!.apply(
                      color: _theme.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    isShowing = false;
    Navigator.of(context, rootNavigator: false).pop(LoadingDialog);
  }
}
