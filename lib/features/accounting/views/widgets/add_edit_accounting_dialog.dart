import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sockettest/app/config/app_helper.dart';
import 'package:sockettest/app/network/request_status.dart';
import 'package:sockettest/app/widgets/custom_button.dart';
import 'package:sockettest/app/widgets/custom_drop_down_button.dart';
import 'package:sockettest/app/widgets/custom_text_field.dart';
import 'package:sockettest/features/accounting/controllers/add_edit_transaction_controller.dart';

import '../../../accounts/controllers/accounts_page_controller.dart';

class AddEditAccountingDialog extends StatelessWidget {
  const AddEditAccountingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddEditTransactionDialogController());
    final accountsController = Get.find<AccountsPageController>();

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      content: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<AddEditTransactionDialogController>(
                    id: controller.accountNameUpdateKey,
                    builder: (logic) {
                      return CustomDropDownButton(
                        title: 'Account Name:',
                        selectedItem: controller.selectedAccountName,
                        targetList: accountsController.accountsList
                            .map((e) => e.name ?? '')
                            .toSet()
                            .toList(),
                        onChanged: (p0) {
                          controller.changeAccountName(p0 ?? '');
                        },
                      );
                    },
                  )
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<AddEditTransactionDialogController>(
                    id: controller.selectStatusUpdateKey,
                    builder: (logic) {
                      return CustomDropDownButton(
                        title: 'Status: ',
                        selectedItem: controller.selectedStatus,
                        targetList: ['Withdraw', 'Deposit'],
                        onChanged: (p0) {
                          controller.changeStatus(p0 ?? '');
                        },
                      );
                    },
                  )
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description: '),
                  SizedBox(height: 10),
                  CustomTextField(
                    checkValidation: (value) =>
                        AppHelper.checkValidation(value ?? ''),
                    controller: controller.descriptionController,
                    maxLines: 5,
                    hintText: 'Write description',
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
                  Text('Amount: '),
                  SizedBox(height: 10),
                  CustomTextField(
                    checkValidation: (value) =>
                        AppHelper.checkValidation(value ?? ''),
                    controller: controller.amountController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      NumberInputFormatter(),
                    ],
                    keyboardType: TextInputType.number,
                    hintText: 'Enter amount',
                    enableBorder: false,
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                    textColor: Theme.of(context).colorScheme.tertiary,
                  )
                ],
              ),
              SizedBox(height: 40),
              GetBuilder<AddEditTransactionDialogController>(
                id: controller.addTransactionUpdateKey,
                builder: (logic) {
                  return CustomButton(
                    isLoading: controller.addTransactionStatus.status ==
                        Status.loading,
                    text: 'Save',
                    borderRadius: 15,
                    height: 50,
                    onPressed: () {
                      if (controller.formKey.currentState?.validate() ??
                          false) {
                        controller.addNewTransaction();
                      }
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
