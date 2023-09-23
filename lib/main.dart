import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:notify2/boxes.dart';
import 'package:notify2/model/notification.dart';
import 'package:notify2/pages/splash_screen.dart';

import 'package:permission_handler/permission_handler.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  
  Hive.registerAdapter(NotificationDataModelAdapter());
  await Hive.initFlutter();

  keywords = await Hive.openBox('keywords');
  notifications = await Hive.openBox('notification');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true
      ),
      home: const SplashScreen(),
    );
  }
}
