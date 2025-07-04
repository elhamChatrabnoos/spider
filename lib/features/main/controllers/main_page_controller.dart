import 'package:get/get.dart';

class MainPageController extends GetxController {
  // tabs
  int currentBottomTabIndex = 0;

  void Function() onTapNavItem(int index) {
    return () {
      currentBottomTabIndex = index;
      update(['currentBottomTabIndex']);
    };
  }

  void changeIndex(int index) {
    currentBottomTabIndex = index;
    update(['currentBottomTabIndex']);
  }

  @override
  void onInit() {
    super.onInit();
    final int? index = Get.arguments?['index'];
    if (index != null) {
      currentBottomTabIndex = index;
    }
  }

}
