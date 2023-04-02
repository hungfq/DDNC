import 'package:ddnc_new/commons/constants.dart';
import 'package:flutter/material.dart';

class AppTransitions {
  static Widget sizeVerticalTransition(
    Widget child,
    Animation<double> animation,
  ) =>
      SizeTransition(
        sizeFactor: animation,
        axisAlignment: 0.0,
        axis: Axis.vertical,
        child: child,
      );

  static Widget slideTransition(
    Widget child,
    Animation<double> animation, {
    Offset begin = const Offset(0, 1),
    Offset end = const Offset(0, 0),
  }) =>
      SlideTransition(
        position: Tween<Offset>(begin: begin, end: end).animate(animation),
        child: child,
      );

  static Widget fadeTransition(
    Widget child,
    Animation<double> animation,
  ) =>
      FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Constants.defaultCurve,
        ),
        child: child,
      );

  static Widget scaleTransition(
      Widget child,
      Animation<double> animation,
      ) =>
      ScaleTransition(
        scale: animation,
        child: child,
      );
}
