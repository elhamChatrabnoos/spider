import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sockettest/features/accounting/controllers/accounting_page_controller.dart';
import 'package:sockettest/features/accounting/views/widgets/accounting_item.dart';
import 'package:sockettest/features/accounting/views/widgets/add_edit_accounting_dialog.dart';
import 'package:sockettest/features/accounts/controllers/accounts_page_controller.dart';

class AccountingPage extends GetView<AccountingPageController> {
  const AccountingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AccountingPageController());
    Get.put(AccountsPageController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Accounting'),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddEditAccountingDialog(),
          );
        },
      ),
      body: GetBuilder<AccountingPageController>(
        id: controller.transactionsUpdateKey,
        builder: (logic) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemCount: controller.transactionList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return AccountingItem(
                transaction: controller.transactionList[index],
              );
            },
          );
        },
      ),
    );
  }
}
