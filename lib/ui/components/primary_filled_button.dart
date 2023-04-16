import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/material.dart';

class PrimaryFilledButton extends StatelessWidget {
  final Function()? onClick;

  final String labelText;
  final Widget? icon;
  final bool widthWrap;
  final bool heightWrap;
  final Color? backgroundColor;

  const PrimaryFilledButton(
      {Key? key,
      required this.labelText,
      this.onClick,
      this.widthWrap = true,
      this.heightWrap = false,
      this.icon,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      width: widthWrap ? null : double.infinity,
      height: heightWrap ? null : Dimens.buttonHeight,
      child: icon != null
          ? ElevatedButton.icon(
              onPressed: onClick,
              icon: icon ?? const SizedBox(),
              label: Text(
                labelText.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              style: backgroundColor != null
                  ? ElevatedButton.styleFrom(
                      primary: backgroundColor,
                    )
                  : null,
            )
          : ElevatedButton(
              onPressed: onClick,
              child: Text(
                labelText.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              style: backgroundColor != null
                  ? ElevatedButton.styleFrom(
                      primary: backgroundColor,
                    )
                  : null,
            ),
    );
  }
}
