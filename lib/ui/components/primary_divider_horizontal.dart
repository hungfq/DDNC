import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/material.dart';

class PrimaryDividerHorizontal extends StatelessWidget {
  final double width;
  final Color? color;

  const PrimaryDividerHorizontal(
      {Key? key, this.width = Dimens.smallComponentStrokeWidth, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DividerThemeData dividerTheme = theme.dividerTheme;

    return SizedBox(
      height: width,
      child: Center(
        child: Container(
          height: width,
          margin: EdgeInsetsDirectional.only(
              start: dividerTheme.indent ?? 0.0,
              end: dividerTheme.endIndent ?? 0.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: createBorderSide(context,
                  color: color ?? theme.dividerColor, width: width),
            ),
          ),
        ),
      ),
    );
  }

  static BorderSide createBorderSide(BuildContext? context,
      {Color? color, double? width}) {
    final Color? effectiveColor = color ??
        (context != null
            ? (DividerTheme.of(context).color ?? Theme.of(context).dividerColor)
            : null);
    final double effectiveWidth = width ??
        (context != null ? DividerTheme.of(context).thickness : null) ??
        0.0;

    // Prevent assertion since it is possible that context is null and no color
    // is specified.
    if (effectiveColor == null) {
      return BorderSide(
        width: effectiveWidth,
      );
    }
    return BorderSide(
      color: effectiveColor,
      width: effectiveWidth,
    );
  }
}
