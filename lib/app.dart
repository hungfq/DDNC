import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'app_router.dart';
import 'commons/app_page.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      hideFooterWhenNotFull: true,
      enableLoadingWhenNoData: false,
      child: const MaterialApp(
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppPages.signInPage,
      ),
    );
  }
}
