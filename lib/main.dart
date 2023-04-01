import 'package:ddnc_new/providers/user_provider.dart';
import 'package:ddnc_new/ui/homepage1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ddnc_new/login_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (_) => UserProvider(),
    child: MaterialApp(
      title: 'DDNC',
      home: HomePage( title: 'Admin page',),
    ),
  ));
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(ChangeNotifierProvider(
//     create: (context) => UserProvider(),
//     child: MaterialApp(
//       title: 'DDNC',
//       home: LoginPage(),
//     ),
//   ));
// }
