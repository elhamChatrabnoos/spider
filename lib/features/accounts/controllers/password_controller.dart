import 'package:get/get.dart';

class PasswordFieldController extends GetxController{

  bool showPassword = true;
  bool showConfirmPassword = true;
  final String passwordFieldUpdateKey = 'passwordFieldUpdateKey';
  final String confPasswordFieldUpdateKey = 'confPasswordFieldUpdateKey';

  void changePasswordVisibility() {
    showPassword = !showPassword;
    update([passwordFieldUpdateKey]);
  }

  void changeConfirmPasswordVisibility() {
    showConfirmPassword = !showConfirmPassword;
    update([confPasswordFieldUpdateKey]);
  }

}