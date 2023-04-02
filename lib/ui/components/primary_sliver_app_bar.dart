import 'package:flutter/material.dart';

class PrimarySliverAppBar extends StatelessWidget with PreferredSizeWidget {
  const PrimarySliverAppBar({
    Key? key,
    required this.title,
    this.expandedHeight,
    this.actions,
    this.elevation,
    this.pinned,
    this.leading,
    this.backgroundColor,
    this.onBackgroundColor,
    this.titleSpacing,
    this.bottom,
    this.floating,
    this.titleStyle,
    this.toolbarHeight,
    this.leadingWidth,
    this.titleWidget,
  }) : super(key: key);

  final String title;
  final double? toolbarHeight;
  final double? expandedHeight;
  final double? elevation;
  final double? leadingWidth;
  final double? titleSpacing;
  final List<Widget>? actions;
  final Widget? leading;
  final PreferredSizeWidget? bottom;

  final TextStyle? titleStyle;
  final Widget? titleWidget;

  final Color? backgroundColor;
  final Color? onBackgroundColor;

  final bool? pinned;
  final bool? floating;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: expandedHeight,
      floating: floating ?? false,
      pinned: pinned ?? true,
      leading: leading,
      automaticallyImplyLeading: leading == null,
      titleSpacing: titleSpacing,
      leadingWidth: leadingWidth,
      toolbarHeight: toolbarHeight ?? kToolbarHeight,
      title: titleWidget ?? Text(title),
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(expandedHeight ?? kToolbarHeight);
}
