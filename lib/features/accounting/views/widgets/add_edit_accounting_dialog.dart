import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sockettest/app/widgets/custom_button.dart';
import 'package:sockettest/app/widgets/custom_drop_down.dart';
import 'package:sockettest/app/widgets/custom_text_field.dart';
import 'package:sockettest/features/accounting/controllers/add_edit_accounting_controller.dart';

class AddEditAccountingDialog extends StatelessWidget {
  const AddEditAccountingDialog({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddEditDialogController());

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Account Name: '),
                SizedBox(height: 10),
                GetBuilder<AddEditDialogController>(
                    id: controller.accountNameUpdateKey,
                    builder: (logic) {
                      return CustomDropDownField(
                        value: controller.selectedAccountName,
                        targetList: ['Elham', 'Hossein'],
                        hintText: 'Select account',
                        onChanged: (p0) {
                          controller.changeAccountName(p0 ?? '');
                        },
                      );
                    })
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status: '),
                SizedBox(height: 10),
                GetBuilder<AddEditDialogController>(
                    id: controller.selectStatusUpdateKey,
                    builder: (logic) {
                      return CustomDropDownField(
                        value: controller.selectedStatus,
                        targetList: ['Pick', 'Deposit'],
                        hintText: 'Select type',
                        onChanged: (p0) {
                          controller.changeStatus(p0 ?? '');
                        },
                      );
                    })
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Description: '),
                SizedBox(height: 10),
                CustomTextField(
                  maxLines: 5,
                  hintText: 'Write description',
                  enableBorder: false,
                  fillColor: Theme.of(context).colorScheme.onPrimary,
                  textColor: Theme.of(context).colorScheme.primary,
                )
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cost: '),
                SizedBox(height: 10),
                CustomTextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  hintText: 'Enter cost',
                  enableBorder: false,
                  fillColor: Theme.of(context).colorScheme.onPrimary,
                  textColor: Theme.of(context).colorScheme.primary,
                )
              ],
            ),
            SizedBox(height: 40),
            CustomButton(
              text: 'Save',
              borderRadius: 15,
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
