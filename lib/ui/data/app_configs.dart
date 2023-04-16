import 'package:ddnc_new/commons/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppConfigs extends ChangeNotifier {
  ThemeMode _theme = ThemeMode.light;

  String _langCode = Constants.defaultLocale;

  // Theme index
  static const lightThemeIndex = 0;
  static const darkThemeIndex = 1;
  static const systemDefaultThemeIndex = 3;

  //region getters & setters
  String get langCode => _langCode;

  set langCode(String value) {
    _langCode = value;
    notifyListeners();
  }

  ThemeMode get theme => _theme;

  void setTheme(ThemeMode theme) {
    _theme = theme;
    notifyListeners();
  }

  int getThemeMode() {
    switch (_theme) {
      case ThemeMode.light:
        return lightThemeIndex;
      case ThemeMode.dark:
        return darkThemeIndex;
      default:
        return systemDefaultThemeIndex;
    }
  }

  //endregion

  static AppConfigs of(BuildContext context) =>
      Provider.of<AppConfigs>(context, listen: false);
}
