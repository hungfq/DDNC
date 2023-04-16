import 'package:flutter/material.dart';

class DashboardMenu {
  String title;
  final String permissionName;
  final String accountPermissionName;
  final String pageRoute;
  final List<String> subPages;
  final String imageUrl;
  final IconData? icon;

  DashboardMenu({
    required this.title,
    required this.permissionName,
    required this.accountPermissionName,
    required this.pageRoute,
    required this.subPages,
    required this.imageUrl,
    required this.icon,
  });
}
