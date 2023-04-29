import 'dart:async';

import 'package:ddnc_new/app.dart';
import 'package:ddnc_new/di/socket_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ddnc_new/ui/homepage1.dart';

import 'di/global_providers.dart';

// Future<void> main() async {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//   runApp(ChangeNotifierProvider(
//     create: (_) => UserProvider(),
//     child: MaterialApp(
//       title: 'DDNC',
//       home: HomePage( title: 'Admin page',),
//     ),
//   ));
// }

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // SocketManager().connect('http://http://144.126.242.142:8002');
  SocketManager().connect('http://10.0.2.2:8002');

  runApp(MultiProvider(providers: globalProviders, child: const App()));
}
