class DashboardMenu {
  String title;
  final String permissionName;
  final String accountPermissionName;
  final String pageRoute;
  final List<String> subPages;

  DashboardMenu({
    required this.title,
    required this.permissionName,
    required this.accountPermissionName,
    required this.pageRoute,
    required this.subPages,
  });
}
