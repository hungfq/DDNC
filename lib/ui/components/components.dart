import 'package:ddnc_new/ui/resources/colors.dart';
import 'package:flutter/material.dart';

class Components {
  static const primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.lightPrimaryColor,
      AppColors.lightPrimaryVariantColor,
    ],
  );

  static const boxShadowBottom = BoxShadow(
    color: Colors.black26,
    offset: Offset(2.0, 2.0),
    blurRadius: 4.0,
  );

  static const boxShadowTop = BoxShadow(
    color: Colors.black12,
    offset: Offset(0.0, -5.0),
    blurRadius: 4.0,
  );

  static const boxShadowAll = BoxShadow(
    color: Colors.black26,
    spreadRadius: 1,
    blurRadius: 5,
    offset: Offset(0, 1),
  );

}