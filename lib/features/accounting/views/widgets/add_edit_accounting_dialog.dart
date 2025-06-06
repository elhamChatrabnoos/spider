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

class AddEditAccountingDialog extends StatelessWidget {
  const AddEditAccountingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddEditTransactionDialogController());
    controller.getReasons();

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        Get.delete<AddEditTransactionDialogController>();
      },
      child: AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        content: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     GetBuilder<AddEditTransactionDialogController>(
                //       id: controller.accountNameUpdateKey,
                //       builder: (logic) {
                //         return CustomDropDownButton(
                //           title: 'Account Name:',
                //           selectedItem: controller.selectedAccountName,
                //           targetList: accountsController.accountsList
                //               .map((e) => e.name ?? '')
                //               .toSet()
                //               .toList(),
                //           onChanged: (p0) {
                //             controller.changeAccountName(p0 ?? '');
                //           },
                //         );
                //       },
                //     )
                //   ],
                // ),
                // SizedBox(height: 20),
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
                    Text('Reason: '),
                    SizedBox(height: 10),
                    GetBuilder<AddEditTransactionDialogController>(
                      id: controller.getReasonsUpdateKey,
                      builder: (logic) {
                        return Autocomplete<Reason>(
                          fieldViewBuilder: (context, textEditingController,
                              focusNode, onFieldSubmitted) {
                            controller.reasonController = textEditingController;
                            return CustomTextField(
                              focusNode: focusNode,
                              checkValidation: (value) =>
                                  AppHelper.checkValidation(value ?? ''),
                              controller: textEditingController,
                              hintText: 'Enter reason',
                              enableBorder: false,
                              fillColor: Theme.of(context).colorScheme.onPrimary,
                              textColor: Theme.of(context).colorScheme.tertiary,
                            );
                          },
                          optionsMaxHeight: MediaQuery.sizeOf(context).height / 3,
                          optionsViewBuilder: (context, onSelected, options) {
                            if (logic.getReasonsStatus.status == Status.success)
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width: MediaQuery.sizeOf(context).width / 1.5,
                                  height: MediaQuery.sizeOf(context).height / 10,
                                  decoration: BoxDecoration(color: Colors.grey),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      spacing: 10,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: options
                                          .map(
                                            (e) => InkWell(
                                              onTap: () {
                                                onSelected(e);
                                                controller.reasonController.text =
                                                    e.causes ?? '';
                                                FocusScope.of(context)
                                                    .requestFocus(FocusNode());
                                              },
                                              child: Text(e.causes ?? ''),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ),
                              );
                            return SizedBox();
                          },
                          optionsBuilder: (textEditingValue) {
                            if (logic.reasonsList.isEmpty) {
                              return [];
                            }
                            return logic.reasonsList.where((element) => element
                                .causes!
                                .contains(textEditingValue.text.toLowerCase()));
                          },
                        );
                      },
                    ),
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
