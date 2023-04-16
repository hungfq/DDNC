import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/material.dart';

class PrimaryOutlinedButton extends StatelessWidget {
  final Function()? onClick;

  final String labelText;
  final Icon? icon;
  final bool widthWrap;
  final bool heightWrap;
  final double? height;
  final Color? backgroundColor;

  const PrimaryOutlinedButton({
    Key? key,
    this.onClick,
    this.labelText = "",
    this.widthWrap = true,
    this.heightWrap = false,
    this.icon,
    this.backgroundColor,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var buttonStyle = OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.buttonRadius),
        side: BorderSide(
          color: backgroundColor ?? theme.colorScheme.secondary,
          width: Dimens.outlinedButtonStrokeWidth,
        ),
      ),
      splashFactory: NoSplash.splashFactory,
      // primary: theme.colorScheme.secondary,
      side: BorderSide(
        color: backgroundColor ?? theme.colorScheme.secondary,
        width: Dimens.outlinedButtonStrokeWidth,
      ),
    );

    return SizedBox(
      width: widthWrap ? null : double.infinity,
      height: height ?? (heightWrap
              ? null
              : Dimens.buttonHeight),
      child: icon != null
          ? OutlinedButton.icon(
              style: buttonStyle,
              onPressed: onClick,
              icon: icon!,
              label: Text(
                labelText.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: backgroundColor ?? theme.colorScheme.secondary,
                ),
              ),
            )
          : OutlinedButton(
              style: buttonStyle,
              onPressed: onClick,
              child: Text(
                labelText.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: backgroundColor ?? theme.colorScheme.secondary,
                ),
              ),
            ),
    );
  }
}
