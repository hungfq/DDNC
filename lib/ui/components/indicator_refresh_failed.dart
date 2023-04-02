import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndicatorRefreshingFailed extends StatelessWidget {
  final String errorMessage;

  const IndicatorRefreshingFailed({Key? key, required this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          CupertinoIcons.clear_circled,
          size: Dimens.iconXSize,
        ),
        Text(
          errorMessage,
        ),
      ],
    );
  }
}
