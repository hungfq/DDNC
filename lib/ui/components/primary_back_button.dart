import 'package:ddnc_new/modules/navigation/navigation_service.dart';
import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/material.dart';

class PrimaryBackButton extends StatelessWidget {
  const PrimaryBackButton({Key? key, this.color}) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => NavigationService.instance.pop(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.marginPaddingSizeXXMini,
          vertical: Dimens.marginPaddingSizeXMini,
        ),
        child: Icon(
          Icons.arrow_back_ios,
          color: color ?? theme.colorScheme.onSurface,
          size: Dimens.iconSize,
        ),
      ),
    );
  }
}
