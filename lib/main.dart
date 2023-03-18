import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ddnc_new/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LoginPage());
}
