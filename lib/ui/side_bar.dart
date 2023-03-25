import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

class SideBar extends StatelessWidget {
  final SideMenuController sideMenu;
  const SideBar({
    super.key,
    required this.sideMenu,
  });

  @override
  Widget build(BuildContext context) {
    return  SideMenu(
      controller: sideMenu,
      style: SideMenuStyle(
        displayMode: SideMenuDisplayMode.auto,
        hoverColor: Colors.blue[100],
        selectedColor: Colors.lightBlue,
        selectedTitleTextStyle: const TextStyle(color: Colors.white),
        selectedIconColor: Colors.white,
      ),
      title: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 150,
              maxWidth: 150,
            ),
            child: Image.asset(
              'assets/images/fit.png',
            ),
          ),
          const Divider(
            indent: 8.0,
            endIndent: 8.0,
          ),
        ],
      ),
      footer: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Khoa CNTT',
          style: TextStyle(fontSize: 15),
        ),
      ),
      items: [
        SideMenuItem(
          priority: 0,
          title: 'ADMIN',
          onTap: (page, _) {
            // showTooltip: false,
            sideMenu.changePage(page);
          },
          icon: const Icon(Icons.admin_panel_settings),
          badgeContent: const Text(
            '3',
            style: TextStyle(color: Colors.white),
          ),
          tooltipContent: "Admin",
        ),
        SideMenuItem(
          priority: 1,
          title: 'Giang vien',
          onTap: (page, _) {
            sideMenu.changePage(page);
          },
          icon: const Icon(Icons.supervised_user_circle_sharp),
        ),
        SideMenuItem(
          priority: 2,
          title: 'Sinh vien',
          onTap: (page, _) {
            sideMenu.changePage(page);
          },
          icon: const Icon(Icons.group),
        ),
        SideMenuItem(
          priority: 3,
          title: 'Hoi dong',
          onTap: (page, _) {
            sideMenu.changePage(page);
          },
          icon: const Icon(Icons.download),
        ),
        SideMenuItem(
          priority: 4,
          title: 'De tai',
          onTap: (page, _) {
            sideMenu.changePage(page);
          },
          icon: const Icon(Icons.settings),
        ),
        SideMenuItem(
          priority: 5,
          title: 'Lich dang ky',
          onTap: (page, _) {
            sideMenu.changePage(page);
          },
          icon: const Icon(Icons.edit_calendar),
        ),
        const SideMenuItem(
          priority: 6,
          title: 'Exit',
          icon: Icon(Icons.exit_to_app),
        ),
      ],
    );
  }
}
