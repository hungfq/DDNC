import 'package:flutter/material.dart';

class IndicatorCanRefresh extends StatelessWidget {
  const IndicatorCanRefresh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: const [
        Text(
          "Release to refresh",
        ),
      ],
    );
  }
}
