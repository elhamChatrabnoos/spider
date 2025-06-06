import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sockettest/app/config/app_assets.dart';
import 'package:sockettest/app/config/app_helper.dart';
import 'package:sockettest/app/config/app_text.dart';
import 'package:sockettest/app/network/request_status.dart';
import 'package:sockettest/app/widgets/custom_text_field.dart';
import 'package:sockettest/features/login/controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginController());
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(child: Image.asset(AppAssets.whiteLogo)),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  color: Colors.black.withValues(alpha: 0.6),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Enter Password',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        'Your Password should be at least 4 character, including at least 1 letter.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: passwordController,
                              enableBorder: false,
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.3),
                              borderRaduis: 30,
                            ),
                          ),
                          GetBuilder<LoginController>(
                            id: LoginController().loginUserUpdateKey,
                            builder: (logic) {
                              return TextButton(
                                onPressed: () {
                                  if (passwordController.text.isNotEmpty &&
                                      logic.loginUserStatus.status !=
                                          Status.loading) {
                                    logic.loginUser(passwordController.text);
                                  }
                                },
                                child: (logic.loginUserStatus.status ==
                                        Status.loading)
                                    ? CircularProgressIndicator()
                                    : Text(
                                        'GO',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                              );
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
