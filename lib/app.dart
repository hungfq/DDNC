import 'package:ddnc_new/ui/data/app_configs.dart';
import 'package:ddnc_new/ui/data/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'app_router.dart';
import 'commons/app_page.dart';
import 'commons/shared_preferences_helpers.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool _isInit = false;

  @override
  Future<void> didChangeDependencies() async {
    if (!_isInit) {
      _isInit = true;
      SharedPreferencesHelpers instance =
          await SharedPreferencesHelpers.getInstance();
      int themeIndex =
          instance.getFromDisk<int>(SharedPreferencesHelpers.themeModeKey) ??
              AppConfigs.lightThemeIndex;
      switch (themeIndex) {
        case AppConfigs.lightThemeIndex:
          AppConfigs.of(context).setTheme(ThemeMode.light);
          break;
        case AppConfigs.darkThemeIndex:
          AppConfigs.of(context).setTheme(ThemeMode.dark);
          break;
        case AppConfigs.systemDefaultThemeIndex:
          AppConfigs.of(context).setTheme(ThemeMode.system);
          break;
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      hideFooterWhenNotFull: true,
      enableLoadingWhenNoData: false,
      child: MaterialApp(
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        themeMode: context.watch<AppConfigs>().theme,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppPages.signInPage,
      ),
    );
  }
}
