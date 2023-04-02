import 'package:flutter/material.dart';

class DashboardMenu {
  String title;
  String? index;
  final String permissionName;
  final String accountPermissionName;
  final String pageRoute;
  final List<String> subPages;

  DashboardMenu({
    required this.title,
    required this.index,
    required this.permissionName,
    required this.accountPermissionName,
    required this.pageRoute,
    required this.subPages,
  });
}
