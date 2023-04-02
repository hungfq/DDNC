import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension StringUtils on String? {
  bool isNullOrEmpty() => this == null || this!.trim().isEmpty;

  String format(var arguments) => sprintf(this ?? "", arguments);

  bool toBool() => this == '1';

  int? toInt() => isNullOrEmpty() ? null : int.parse(this!);

  double? toDouble() => isNullOrEmpty() ? null : double.parse(this!);

  bool equalIgnoreCase(String value) => this?.toLowerCase() == value.toLowerCase();
}

extension IntUtils on int {
  bool toBool() => this == 1;
}

extension FileUtils on File {
  int sizeInKB() => lengthSync() ~/ 1048576;
}

extension TextEditingControllerUtils on TextEditingController {
  void setText(String value) => this
    ..text = value
    ..selection =
        TextSelection.fromPosition(TextPosition(offset: value.length));
}
