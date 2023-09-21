import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:notify2/boxes.dart';
import 'package:notify2/model/notification.dart';
import 'package:notify2/navigation_home_screen.dart';

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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // textTheme: GoogleFonts.,
        platform: TargetPlatform.iOS,
        useMaterial3: true
      ),
      home: NavigationHomeScreen(),
    );
  }
}

// class HexColor extends Color {
//   HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

//   static int _getColorFromHex(String hexColor) {
//     hexColor = hexColor.toUpperCase().replaceAll('#', '');
//     if (hexColor.length == 6) {
//       hexColor = 'FF' + hexColor;
//     }
//     return int.parse(hexColor, radix: 16);
//   }
// }
