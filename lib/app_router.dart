import 'package:ddnc_new/repositories/account_repository.dart';
import 'package:ddnc_new/repositories/user_repository.dart';
import 'package:ddnc_new/ui/homepage1.dart';
import 'package:ddnc_new/ui/pages/master/blocs/master_bloc.dart';
import 'package:ddnc_new/ui/pages/master/master_page.dart';
import 'package:ddnc_new/ui/pages/sign_in/blocs/sign_in_bloc.dart';
import 'package:ddnc_new/ui/pages/sign_in/sign_in_page.dart';
import 'package:ddnc_new/ui/pages/user/user_list/blocs/user_list_bloc.dart';
import 'package:ddnc_new/ui/pages/user/user_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'commons/app_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //region systems
      case AppPages.masterPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => MasterBloc(
              accountRepository: AccountRepository.of(context),
            ),
            child: const MasterPage(),
          ),
          settings: settings,
        );
      case AppPages.signInPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SignInBloc>(
            create: (context) => SignInBloc(
              accountRepository: AccountRepository.of(context),
            ),
            child: const LoginPage(),
          ),
          settings: settings,
        );
      case AppPages.homePage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<UserListBloc>(
            create: (context) => UserListBloc(
              userRepository: UserRepository.of(context),
            ),
            child: const HomePage(title: 'Admin Page'),
          ),
          settings: settings,
        );
      case AppPages.userListPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<UserListBloc>(
            create: (context) => UserListBloc(
              userRepository: UserRepository.of(context),
            ),
            child: const UserListPage(),
          ),
          settings: settings,
        );
      //endregion
      default:
        return CupertinoPageRoute(
          builder: (_) => UndefinedView(
            routeName: settings.name,
          ),
          settings: settings,
        );
    }
  }
}

class UndefinedView extends StatelessWidget {
  final String? routeName;

  const UndefinedView({Key? key, this.routeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Route for ${routeName ?? 'no name'} is not defined'),
      ),
    );
  }
}
