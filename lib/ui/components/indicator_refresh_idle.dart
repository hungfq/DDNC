import 'package:flutter/material.dart';

class IndicatorRefreshIdle extends StatelessWidget {
  const IndicatorRefreshIdle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          "Pull to refresh",
        ),
      ],
    );
  }
}
