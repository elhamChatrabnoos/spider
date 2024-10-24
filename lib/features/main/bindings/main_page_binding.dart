import 'package:get/get.dart';
import 'package:sockettest/features/main/controllers/main_page_controller.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(fenix: true, () => MainPageController());
  }
}
