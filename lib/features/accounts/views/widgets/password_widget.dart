import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sockettest/features/accounts/controllers/password_controller.dart';

import '../../../../app/config/app_helper.dart';
import '../../../../app/widgets/custom_text_field.dart';

class PasswordFieldWidget extends StatelessWidget {
  const PasswordFieldWidget({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {

    Get.lazyPut(() => PasswordFieldController());

    return GetBuilder<PasswordFieldController>(
      id: Get.find<PasswordFieldController>().passwordFieldUpdateKey,
      builder: (controller) {
        return CustomTextField(
          controller: this.controller,
          checkValidation: (value) => AppHelper.checkValidation(value!),
          suffixIcon: InkWell(
            onTap: () => controller.changePasswordVisibility(),
            child: Icon(
              color: Theme.of(context).colorScheme.tertiary,
              controller.showPassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              size: 24,
            ),
          ),
          obscureText: controller.showPassword,
          textColor: Theme.of(context).colorScheme.tertiary,
          enableBorder: true,
          hintText: 'Password',
        );
      },
    );
  }
}
