import 'package:ddnc_new/commons/constants.dart';
import 'package:flutter/material.dart';

class SystemPadding extends StatelessWidget {
  final Widget child;

  const SystemPadding({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return AnimatedContainer(
      padding: mediaQuery.viewInsets,
      duration: const Duration(milliseconds: Constants.animationDuration),
      child: child,
    );
  }
}
