import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sockettest/app/config/app_helper.dart';
import 'package:sockettest/app/network/request_status.dart';
import 'package:sockettest/app/widgets/custom_button.dart';
import 'package:sockettest/app/widgets/custom_text_field.dart';
import 'package:sockettest/features/accounts/controllers/add_edit_account_controller.dart';
import 'package:sockettest/features/accounts/models/get_account_response.dart';
import 'package:sockettest/features/accounts/views/widgets/password_widget.dart';

class AddEditAccountDialog extends GetView<AddEditAccountController> {
  const AddEditAccountDialog({ this.account, super.key});

  final Account? account;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddEditAccountController());
    if(account != null){
      controller.nameController.text = account!.name ?? '';
      controller.balanceController.text = account!.balance.toString();
    }

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      content: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add new Account',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: '),
                  SizedBox(height: 10),
                  CustomTextField(
                    checkValidation: (value) =>
                        AppHelper.checkValidation(value ?? ''),
                    controller: controller.nameController,
                    hintText: 'Account name',
                    enableBorder: false,
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                    textColor: Theme.of(context).colorScheme.tertiary,
                  )
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Password: '),
                  SizedBox(height: 10),
                  PasswordFieldWidget(
                      controller: controller.passwordController),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Balance: '),
                  SizedBox(height: 10),
                  CustomTextField(
                    checkValidation: (value) =>
                        AppHelper.checkValidation(value ?? ''),
                    controller: controller.balanceController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      NumberInputFormatter(),
                    ],
                    keyboardType: TextInputType.number,
                    hintText: 'Balance value',
                    enableBorder: false,
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                    textColor: Theme.of(context).colorScheme.tertiary,
                  )
                ],
              ),
              SizedBox(height: 40),
              GetBuilder<AddEditAccountController>(
                  id: controller.addEditAccountUpdateKey,
                  builder: (logic) {
                    // WidgetsBinding.instance.addPostFrameCallback(
                    //   (timeStamp) {
                    //     if(controller.addEditAccountStatus.status == Status.success){
                    //       AppHelper.customPrint('message');
                    //       Get.delete();
                    //     }
                    //   },
                    // );
                    return CustomButton(
                      isLoading:
                          logic.addEditAccountStatus.status == Status.loading,
                      text: 'Save',
                      borderRadius: 15,
                      height: 50,
                      onPressed: () {
                        if (controller.formKey.currentState?.validate() ??
                            false) {
                          controller.addAccount();
                        }
                      },
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
