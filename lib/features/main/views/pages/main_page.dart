import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sockettest/app/widgets/my_bottom_tab_bar_widget.dart';
import 'package:sockettest/features/accounting/views/pages/accounting_page.dart';
import 'package:sockettest/features/accounts/views/pages/accounts_page.dart';
import 'package:sockettest/features/home/views/pages/home_page.dart';
import 'package:sockettest/features/main/controllers/main_page_controller.dart';

class MainPage extends GetView<MainPageController> {
  MainPage({super.key});

  static const routeName = '/tabs';

  final List<Widget> _tabs = [
    HomePage(key: PageStorageKey<String>('page1')),
    AccountingPage(key: PageStorageKey<String>('page2')),
    const AccountsPage(key: PageStorageKey<String>('page3')),
    const SizedBox(key: PageStorageKey<String>('page4'))
  ];
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainPageController>(
      id: 'currentBottomTabIndex',
      builder: (_) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: PopScope(
            canPop: controller.currentBottomTabIndex == 0,
            onPopInvokedWithResult: (didPop, result) {
              if (controller.currentBottomTabIndex != 0) {
                controller.changeIndex(0);
              } else {
                Get.back();
              }
            },
            child: PageStorage(
              bucket: bucket,
              child: _tabs[controller.currentBottomTabIndex],
            ),
          ),
          bottomNavigationBar: MyBottomTabBarWidget(
            currentIndex: controller.currentBottomTabIndex,
            ontapNavItem: controller.onTapNavItem,
          ),
        );
      },
    );
  }
}
