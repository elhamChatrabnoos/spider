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

class AddEditLoanDialog extends StatelessWidget {
  const AddEditLoanDialog({super.key});

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
              spacing: 20,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Title'),
                    SizedBox(height: 10),
                    CustomTextField(
                      checkValidation: (value) =>
                          AppHelper.checkValidation(value ?? ''),
                      controller: controller.amountController,
                      hintText: 'Enter title',
                      enableBorder: true,
                    )
                  ],
                ),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('settlement count '),
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
                      hintText: 'Enter settlement count',
                      enableBorder: true,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date'),
                    SizedBox(height: 10),
                    CustomTextField(
                      onTap: () {
                        
                      },
                      readOnly: true,
                      checkValidation: (value) =>
                          AppHelper.checkValidation(value ?? ''),
                      controller: controller.amountController,
                      keyboardType: TextInputType.number,
                      hintText: 'Enter date',
                      enableBorder: true,
                    )
                  ],
                ),
                SizedBox(height: 20),
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
