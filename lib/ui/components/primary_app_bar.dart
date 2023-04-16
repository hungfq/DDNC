import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryAppBar extends StatelessWidget with PreferredSizeWidget {
  const PrimaryAppBar({
    Key? key,
    this.actions,
    required this.title,
    this.toolbarHeight,
    this.bottom,
    this.leading,
    this.elevation,
    this.backgroundColor,
    this.onBackgroundColor,
    this.titleStyle,
    this.titleWidget,
    this.leadingWidth,
    this.titleSpacing,
    this.shapeBorder,
  }) : super(key: key);

  final ShapeBorder? shapeBorder;
  final List<Widget>? actions;
  final Widget? titleWidget;
  final String title;
  final double? elevation;
  final double? toolbarHeight;
  final PreferredSizeWidget? bottom;
  final Widget? leading;
  final double? leadingWidth;
  final double? titleSpacing;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final Color? onBackgroundColor;

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight != null
      ? toolbarHeight!
      : bottom != null
          ? Dimens.appbarWithTabHeight
          : kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    return AppBar(
      shape: shapeBorder,
      iconTheme: IconThemeData(
        color: onBackgroundColor ?? _theme.colorScheme.onSurface,
      ),
      toolbarHeight: bottom != null
          ? Dimens.appbarWithTabHeight
          : toolbarHeight ?? kToolbarHeight,
      backgroundColor: backgroundColor ?? _theme.backgroundColor,
      elevation: elevation ?? Dimens.primaryAppbarElevation,
      // systemOverlayStyle: context.watch<AppConfigs>().theme == ThemeMode.light
      //     ? SystemUiOverlayStyle.dark
      //     : SystemUiOverlayStyle.light,
      // titleTextStyle: titleStyle ??
      //     Themes.headerTextStyle.apply(
      //       color: onBackgroundColor ?? AppColors.titleColor,
      //     ),
      leadingWidth: leadingWidth,
      titleSpacing: titleSpacing,
      leading: leading,
      automaticallyImplyLeading: leading == null,
      centerTitle: true,
      title: titleWidget ?? Text(title),
      actions: actions,
      bottom: bottom,
    );
  }
}
