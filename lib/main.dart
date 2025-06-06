import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sockettest/app/config/app_helper.dart';
import 'package:sockettest/app/config/app_theme.dart';
import 'package:sockettest/features/login/views/pages/login_page.dart';
import 'package:sockettest/features/main/bindings/main_page_binding.dart';
import 'package:sockettest/features/main/views/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await AppHelper.openLocalDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: MainPageBinding(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appThemeLight(),
      home: LoginPage(),
    );
  }
}
