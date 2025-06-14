import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sockettest/app/config/app_helper.dart';
import 'package:sockettest/app/network/request_status.dart';
import 'package:sockettest/app/widgets/custom_button.dart';
import 'package:sockettest/app/widgets/custom_drop_down_button.dart';
import 'package:sockettest/app/widgets/custom_text_field.dart';
import 'package:sockettest/features/accounting/controllers/add_edit_transaction_controller.dart';
import 'package:sockettest/features/accounting/models/reasons_response_model.dart';
import 'package:sockettest/features/accounting/views/widgets/auto_complete_field.dart';

class AddEditTransactionDialog extends StatelessWidget {
  const AddEditTransactionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddEditTransactionDialogController());
    controller.getReasons();

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        Get.delete<AddEditTransactionDialogController>();
      },
      child: AlertDialog(
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
                      id: controller.selectStatusUpdateKey,
                      builder: (logic) {
                        return CustomDropDownButton(
                          validator: (p0) => controller.selectedStatus == null
                              ? 'Please select transaction type'
                              : null,
                          title: 'Status ',
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
                    Text('Reason '),
                    SizedBox(height: 10),
                    AutoCompleteField(),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Amount '),
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
                      enableBorder: true,
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
                      textColor: Theme.of(context).colorScheme.tertiary,
                      height: 50,
                      onPressed: () {
                        if ((controller.formKey.currentState?.validate() ??
                                false) &&
                            controller.addTransactionStatus.status !=
                                Status.loading) {
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
      ),
    );
  }
}
