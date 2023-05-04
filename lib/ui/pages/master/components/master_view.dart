import 'package:ddnc_new/app_router.dart';
import 'package:ddnc_new/commons/app_page.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/modules/navigation/navigation_service.dart';
import 'package:ddnc_new/ui/dialogs/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/master_bloc.dart';
import '../blocs/master_event.dart';
import '../blocs/master_state.dart';
import 'master_drawer.dart';

class MasterView extends StatefulWidget {
  const MasterView({Key? key}) : super(key: key);

  @override
  State<MasterView> createState() => _MasterViewState();
}

class _MasterViewState extends State<MasterView> {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: Constants.delayTime), () {
      if (!mounted) return;
      NavigationService.instance.navigationKey =
          _navigationKey; // wait the old widget dispose then assign new value
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MasterBloc, MasterState>(
      listener: _listeners,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          endDrawer: const MasterDrawer(),
          body: Navigator(
            key: _navigationKey,
            initialRoute: AppPages.startDestinationPage,
            onGenerateRoute: AppRouter.generateRoute,
            observers: [
              NavigationService.instance.routeObserver,
              HeroController(),
            ],
          ),
        ),
      ),
    );
  }

  void _listeners(BuildContext context, MasterState state) {
    switch (state.runtimeType) {
      case MasterActionState:
        if (state is! MasterActionState) return;
        _handleActionExecuted(state);
        break;
      default:
        break;
    }
  }

  void _handleActionExecuted(MasterActionState state) {
    switch (state.action) {
      case MasterActionEvent.openDrawer:
        if (_scaffoldKey.currentState?.isEndDrawerOpen ?? true) return;
        _scaffoldKey.currentState?.openEndDrawer();
        break;
      default:
        break;
    }
  }

  Future<bool> _onWillPop() async {
    if (_scaffoldKey.currentState?.isEndDrawerOpen ?? false) {
      Navigator.of(context).pop();
      return false;
    } else if (NavigationService.instance.canPop()) {
      NavigationService.instance.pop();
      return false;
    } else {
      bool result = await ConfirmDialog.show(
        context: context,
        question: "Are you sure you want to exit ?",
      );
      return result;
      return true;
    }
  }
}
