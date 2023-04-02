import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/material.dart';

class IndicatorRefreshing extends StatelessWidget {
  const IndicatorRefreshing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        Text(
          "${"Loading"}...",
        ),
      ],
    );
  }
}
