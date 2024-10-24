import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sockettest/app/config/app_theme.dart';
import 'package:sockettest/features/home/views/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appThemeLight(),
      home: HomePage(),
    );
  }
}
