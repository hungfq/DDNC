import 'dart:async';

import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/commons/app_page.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/stream_helpers.dart';
import 'package:ddnc_new/models/dashboard_menu.dart';
import 'package:ddnc_new/repositories/account_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'master_event.dart';
import 'master_state.dart';

class MasterBloc extends Bloc<MasterEvent, MasterState> {
  MasterBloc({
    required AccountRepository accountRepository,
  })  : _accountRepository = accountRepository,
        super(const MasterInitState()) {
    on<MasterActionEvent>(
      _onActionExecuted,
    );
    on<MasterMenuFetchedEvent>(
      _onDashboardMenuCreated,
    );
    on<MasterSignOutEvent>(
      _onSignOut,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
  }

  final AccountRepository _accountRepository;

  final PageStorageKey _pageStorageKey =
      const PageStorageKey("drawer_item_list");
  List<DashboardMenu> _menus = [];
  List<DashboardMenu> _sideMenus = _originalMenuItems;

  String dateFormat = Constants.defaultDateFormat;
  String timeFormat = Constants.defaultTimeFormat;

  List<DashboardMenu> get menus => _menus;

  List<DashboardMenu> get sideMenus => _sideMenus;

  PageStorageKey get pageStorageKey => _pageStorageKey;

  //endregion

  Future<void> _onActionExecuted(
    MasterActionEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(MasterActionState(event.action, event.data));
  }

  Future<void> _onSignOut(
    MasterSignOutEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(MasterSignOutState(Resource.loading()));

    // var result = await _accountRepository.signOut();
    // emit(MasterSignOutState(result));
  }

  Future<void> _onDashboardMenuCreated(
    MasterMenuFetchedEvent event,
    Emitter<MasterState> emit,
  ) async {
    _menus = List.from(_originalMenuItems);

    _sideMenus = [];
    _sideMenus.add(_dashboardMenuItem);
    _sideMenus.addAll(_menus);
    _sideMenus.addAll([
      _settingMenuItem,
      _signOutMenuItem,
    ]);

    emit(const MasterMenuFetchedState());
  }

  //endregion

  //region process
  void dispose() {}

  void signOut() {
    add(const MasterSignOutEvent());
  }

  //region actions
  void onSignOutClicked() {
    add(const MasterActionEvent(MasterActionEvent.signOut));
  }

  void onDrawerMenuClicked() {
    add(const MasterActionEvent(MasterActionEvent.openDrawer));
  }
}

final DashboardMenu _dashboardMenuItem = DashboardMenu(
  title: "Dashboard",
  permissionName: "",
  accountPermissionName: "",
  pageRoute: AppPages.userListPage,
  subPages: [],
);

final List<DashboardMenu> _originalMenuItems = [
  DashboardMenu(
    title: "User",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.userListPage,
    subPages: [AppPages.userDetailPage],
  ),
  DashboardMenu(
    title: "Topic",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.topicListPage,
    subPages: [AppPages.topicDetailPage],
  ),
  DashboardMenu(
    title: "Committee",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.committeeListPage,
    subPages: [AppPages.committeeDetailPage],
  ),
  DashboardMenu(
    title: "Schedule",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.scheduleListPage,
    subPages: [AppPages.scheduleDetailPage],
  ),
  DashboardMenu(
    title: "Mockup Home UI",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.homePage,
    subPages: [],
  ),
];

final DashboardMenu _settingMenuItem = DashboardMenu(
  title: "Settings",
  permissionName: "",
  accountPermissionName: "",
  pageRoute: AppPages.homePage,
  subPages: [
    AppPages.profilePage,
  ],
);

final DashboardMenu _signOutMenuItem = DashboardMenu(
  title: "Sign Out",
  permissionName: "",
  accountPermissionName: "",
  pageRoute: AppPages.homePage,
  subPages: [],
);
