import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/material.dart';

class PrimarySuffixIcon extends StatelessWidget {
  const PrimarySuffixIcon({
    Key? key,
    this.onClicked,
    required this.icon,
  }) : super(key: key);

  final Function()? onClicked;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onClicked,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimens.marginPaddingSizeXMini),
        child: Icon(
          icon,
          size: Dimens.iconSize,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
