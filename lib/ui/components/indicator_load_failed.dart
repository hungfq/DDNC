import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndicatorLoadFailed extends StatelessWidget {
  final String errorMessage;

  const IndicatorLoadFailed({Key? key, required this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Dimens.marginPaddingSizeXMini),
        Text(
          errorMessage,
        ),
      ],
    );
  }
}
