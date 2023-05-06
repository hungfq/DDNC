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

  // List<DashboardMenu> _dashboardMenus = _originalMenuItems;
  List<DashboardMenu> _dashboardMenus = [];

  // List<DashboardMenu> _sideMenus = [
  //   // _notificationMenuItem,
  //   ..._originalMenuItems,
  //   _signOutMenuItem
  // ];

  List<DashboardMenu> _sideMenus = [];

  String dateFormat = Constants.defaultDateFormat;
  String timeFormat = Constants.defaultTimeFormat;

  List<DashboardMenu> get menus => _menus;

  List<DashboardMenu> get sideMenus => _sideMenus;

  List<DashboardMenu> get dashboardMenus => _dashboardMenus;

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

    var result = await _accountRepository.signOut();
    emit(MasterSignOutState(result));
  }

  Future<void> _onDashboardMenuCreated(
    MasterMenuFetchedEvent event,
    Emitter<MasterState> emit,
  ) async {
    // _menus = List.from(_originalMenuItems);
    //
    // _sideMenus = [];
    // _sideMenus.add(_dashboardMenuItem);
    // _sideMenus.addAll(_menus);
    _sideMenus.addAll([
      _settingMenuItem,
      _signOutMenuItem,
    ]);

    emit(const MasterMenuFetchedState());
  }

  Future<void> getMenu() async {
    String role = await _accountRepository.getRole();
    print("======================= ROLE =================");
    print(role);
    if (role == "ADMIN") {
      _dashboardMenus = [
        ..._adminMenuItems,
        _notificationMenuItem,
      ];
      _sideMenus = [
        ..._adminMenuItems,
        _notificationMenuItem,
        _signOutMenuItem
      ];
    } else if (role == "LECTURER") {
      _dashboardMenus = [
        ..._lecturerMenuItems,
        _notificationMenuItem,
      ];
      _sideMenus = [
        ..._lecturerMenuItems,
        _notificationMenuItem,
        _signOutMenuItem
      ];
    } else if (role == "STUDENT") {
      _dashboardMenus = [
        ..._studentMenuItems,
        _notificationMenuItem,
      ];
      _sideMenus = [
        ..._studentMenuItems,
        _notificationMenuItem,
        _signOutMenuItem
      ];
    }
    emit(const MasterMenuFetchedState());
  }

  //region process
  void dispose() {}

  void signOut() {
    add(const MasterSignOutEvent());
  }

  //endregion

  //region actions
  void onSignOutClicked() {
    add(const MasterActionEvent(MasterActionEvent.signOut));
  }

  void onDrawerMenuClicked() {
    add(const MasterActionEvent(MasterActionEvent.openDrawer));
  }
//endregion
}

final DashboardMenu _dashboardMenuItem = DashboardMenu(
  title: "Dashboard",
  permissionName: "",
  accountPermissionName: "",
  pageRoute: AppPages.userListPage,
  subPages: [],
  imageUrl: "",
  icon: null,
);

final List<DashboardMenu> _originalMenuItems = [
  DashboardMenu(
    title: "User",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.userListPage,
    subPages: [AppPages.userDetailPage],
    imageUrl: "images/pic/h_db_user.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Topic",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.topicListPage,
    subPages: [AppPages.topicDetailPage],
    imageUrl: "images/pic/h_db_topic.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Committee",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.committeeListPage,
    subPages: [AppPages.committeeDetailPage],
    imageUrl: "images/pic/h_db_committee.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Schedule",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.scheduleListPage,
    subPages: [AppPages.scheduleDetailPage],
    imageUrl: "images/pic/h_db_schedule.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Approve",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.approveListPage,
    subPages: [],
    imageUrl: "images/pic/h_db_approve.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Mark",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.markListPage,
    subPages: [],
    imageUrl: "images/pic/h_db_mark.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Statistics",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.statsPage,
    subPages: [],
    imageUrl: "images/pic/h_db_stats.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Proposal (ST)",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.topicProposalListPage,
    subPages: [AppPages.topicProposalDetailPage],
    imageUrl: "images/pic/h_db_st_proposal.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Register (ST)",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.registerListPage,
    subPages: [AppPages.registerDetailPage],
    imageUrl: "images/pic/h_db_register.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Result (ST)",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.registerResultPage,
    subPages: [AppPages.registerDetailPage],
    imageUrl: "images/pic/h_db_result.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Approve (LT)",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.proposalApproveListPage,
    subPages: [AppPages.proposalApproveDetailPage],
    imageUrl: "images/pic/h_db_approve.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Mockup UI",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.homePage,
    subPages: [],
    imageUrl: "images/pic/h_db_draw.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Notification",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.notificationPage,
    subPages: [],
    imageUrl: "images/pic/h_db_notification.png",
    icon: IconData(Icons.notifications_outlined.codePoint,
        fontFamily: 'Material'),
  )
];

final List<DashboardMenu> _adminMenuItems = [
  DashboardMenu(
    title: "User",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.userListPage,
    subPages: [AppPages.userDetailPage],
    imageUrl: "images/pic/h_db_user.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Topic",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.topicListPage,
    subPages: [AppPages.topicDetailPage],
    imageUrl: "images/pic/h_db_topic.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Committee",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.committeeListPage,
    subPages: [AppPages.committeeDetailPage],
    imageUrl: "images/pic/h_db_committee.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Schedule",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.scheduleListPage,
    subPages: [AppPages.scheduleDetailPage],
    imageUrl: "images/pic/h_db_schedule.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Approve",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.approveListPage,
    subPages: [],
    imageUrl: "images/pic/h_db_approve.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Statistics",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.statsPage,
    subPages: [],
    imageUrl: "images/pic/h_db_stats.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Mockup UI",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.homePage,
    subPages: [],
    imageUrl: "images/pic/h_db_draw.png",
    icon: null,
  ),
];

final List<DashboardMenu> _lecturerMenuItems = [
  DashboardMenu(
    title: "Topic",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.lecturerTopicListPage,
    subPages: [],
    imageUrl: "images/pic/h_db_topic.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Approve Proposal",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.proposalApproveListPage,
    subPages: [AppPages.proposalApproveDetailPage],
    imageUrl: "images/pic/h_db_approve.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Mark",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.markListPage,
    subPages: [],
    imageUrl: "images/pic/h_db_mark.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Approve Topic",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.lecturerTopicApprovePage,
    subPages: [],
    imageUrl: "images/pic/h_db_approve.png",
    icon: null,
  ),
];

final List<DashboardMenu> _studentMenuItems = [
  DashboardMenu(
    title: "Proposal (ST)",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.topicProposalListPage,
    subPages: [AppPages.topicProposalDetailPage],
    imageUrl: "images/pic/h_db_st_proposal.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Register (ST)",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.registerListPage,
    subPages: [AppPages.registerDetailPage],
    imageUrl: "images/pic/h_db_register.png",
    icon: null,
  ),
  DashboardMenu(
    title: "Result (ST)",
    permissionName: "",
    accountPermissionName: "",
    pageRoute: AppPages.registerResultPage,
    subPages: [AppPages.registerDetailPage],
    imageUrl: "images/pic/h_db_result.png",
    icon: null,
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
  imageUrl: "",
  icon: null,
);

final DashboardMenu _signOutMenuItem = DashboardMenu(
  title: "Sign Out",
  permissionName: "",
  accountPermissionName: "",
  pageRoute: AppPages.signOutPage,
  subPages: [],
  imageUrl: "",
  icon: IconData(0xe3b3, fontFamily: 'MaterialIcons'),
);

final DashboardMenu _notificationMenuItem = DashboardMenu(
  title: "Notification",
  permissionName: "",
  accountPermissionName: "",
  pageRoute: AppPages.notificationPage,
  subPages: [],
  imageUrl: "images/pic/h_db_notification.png",
  icon: IconData(0xe450, fontFamily: 'MaterialIcons'),
);
