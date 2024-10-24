import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sockettest/app/network/request_status.dart';
import 'package:sockettest/app/network/response_status.dart';
import 'package:sockettest/features/accounts/controllers/accounts_page_controller.dart';
import 'package:sockettest/features/accounts/models/get_account_response.dart';
import 'package:sockettest/features/accounts/repository/accounts_repository.dart';

class AddEditAccountController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController balanceController = TextEditingController();

  RequestStatus addEditAccountStatus = RequestStatus();
  final String addEditAccountUpdateKey = 'addEditAccountUpdateKey';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> addAccount() async {
    addEditAccountStatus.loading();
    update([addEditAccountUpdateKey]);

    AccountsRepository accountsRepository = AccountsRepository();
    final responseState = await accountsRepository.addAccount(
      name: nameController.text,
      password: passwordController.text,
      balance: int.tryParse(balanceController.text.replaceAll(',', '')) ?? 0,
    );

    if (responseState is ResponseSuccess<String>) {
      Get.back();
      addEditAccountStatus.success(message: responseState.data, title: 'Success');
      Get.find<AccountsPageController>().addItemToList(
        Account(
          name: nameController.text,
          password: passwordController.text,
          balance: int.tryParse(balanceController.text.replaceAll(',', '')),
        ),
      );
      balanceController.text = '';
      passwordController.text = '';
      nameController.text = '';
      update([addEditAccountUpdateKey]);
      this.onClose();
    }
    if (responseState is ResponseFailed) {
      Get.back();
      addEditAccountStatus.error('${responseState.error}', showMessage: true);
      update([addEditAccountUpdateKey]);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    balanceController.dispose();

    super.dispose();
  }
}
