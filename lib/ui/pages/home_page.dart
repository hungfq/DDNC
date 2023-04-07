// import 'package:flutter/material.dart';
// import 'package:easy_sidemenu/easy_sidemenu.dart';
// import 'package:ddnc_new/ui/side_bar.dart';
// import 'package:ddnc_new/ui/content_section.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   PageController page = PageController();
//   SideMenuController sideMenu = SideMenuController();
//   @override
//   void initState() {
//     sideMenu.addListener((p0) {
//       page.jumpToPage(p0);
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           SideBar(sideMenu: sideMenu),
//           ContentSection(page: page),
//         ],
//       ),
//     );
//   }
// }