import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/material.dart';

class IndicatorLoadNoMore extends StatelessWidget {
  const IndicatorLoadNoMore({
    Key? key,
    this.message,
  }) : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(
        top: Dimens.marginPaddingSizeXXMini,
        right: Dimens.marginPaddingSizeXXMini,
        left: Dimens.marginPaddingSizeXXMini,
      ),
      child: Center(
        child: Text(
          message ?? "No data available",
          style: theme.textTheme.subtitle2!.apply(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
