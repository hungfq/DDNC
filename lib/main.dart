import 'dart:async';

import 'package:ddnc_new/app.dart';
import 'package:ddnc_new/di/socket_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'di/global_providers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  // await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // SocketManager().connect('http://http://144.126.242.142:8002');
  SocketManager().connect('http://10.0.2.2:8002');

  listenForNotifications();

  runApp(MultiProvider(providers: globalProviders, child: const App()));
}

void listenForNotifications() {
  SocketManager().socket.on('notify', (data) async {
    final androidDetails = AndroidNotificationDetails(
        'channelId', 'channelName',
        importance: Importance.max, priority: Priority.high);
    final platformDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
        0, data['title'], data['message'], platformDetails);
  });
}
