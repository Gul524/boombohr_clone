import 'package:demo_app/app/modules/home/home_page.dart';
import 'package:demo_app/app/modules/home/tab_controller.dart';
import 'package:demo_app/app/modules/home/tab_mangement_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  runApp(const BambooFormsApp());
}

class BambooFormsApp extends StatelessWidget {
  const BambooFormsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bamboo Forms',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const HomeScreen(),
      themeMode: StorageService.read('themeMode') == 'dark' ? ThemeMode.dark : ThemeMode.light,
      initialBinding: BindingsBuilder(() {
        final tab = Get.put(AppTabController());
        Get.put(TabManagementController(appTabs: tab));
      }),
    );
  }
}


