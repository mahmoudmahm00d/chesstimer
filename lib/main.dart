import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wakelock/wakelock.dart';

import '/controllers/main_controller.dart';
import 'pages/main_page.dart';
import 'pages/match_page.dart';
import 'pages/statics_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  Wakelock.enable();
  Get.put(MainController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chess Timer',
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/Match', page: () => const MatchPage()),
        GetPage(name: '/Statics', page: () => const StaticsPage()),
      ],
      initialRoute: "/",
      home: const HomePage(),
    );
  }
}
