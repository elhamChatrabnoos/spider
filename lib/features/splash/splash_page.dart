import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sockettest/app/config/app_assets.dart';
import 'package:sockettest/app/config/app_helper.dart';
import 'package:sockettest/app/config/local_db.dart';
import 'package:sockettest/features/login/views/pages/login_page.dart';
import 'package:sockettest/features/main/views/pages/main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _route();
    super.initState();
  }

  Future _route() async {
    await Future.delayed(
      Duration(seconds: 1),
      () async {
        if (await LocalDb.getAccessToken() != null) {
          Get.off(MainPage());
        } else {
          Get.off(LoginPage());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
        children: [
          Image.asset(
            AppAssets.whiteLogo,
            width: MediaQuery.sizeOf(context).width / 5,
          ),
          Text(
            'SPIDER',
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      )),
    );
  }
}
