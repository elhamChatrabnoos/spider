import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sockettest/app/config/app_helper.dart';
import 'package:sockettest/app/network/request_status.dart';
import 'package:sockettest/app/widgets/error_widget.dart';
import 'package:sockettest/app/widgets/my_progress_indicator_widget.dart';
import 'package:sockettest/features/accounting/controllers/accounting_page_controller.dart';
import 'package:sockettest/features/accounting/views/widgets/transaction_item.dart';
import 'package:sockettest/features/accounting/views/widgets/add_edit_accounting_dialog.dart';
import 'package:sockettest/features/accounts/controllers/accounts_page_controller.dart';

class AccountingPage extends GetView<AccountingPageController> {
  const AccountingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AccountingPageController());
    Get.put(AccountsPageController());
    controller.getTransactions(pageNumber: 1);
    return Scaffold(
      appBar: AppBar(
        title: Text('Accounting'),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AddEditAccountingDialog(),
              );
            },
            icon: Icon(
              Icons.add,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
      body: GetBuilder<AccountingPageController>(
        id: controller.transactionsUpdateKey,
        builder: (logic) {
          if (controller.getTransactionsStatus.status == Status.loading) {
            return Center(child: MyProgressIndicator());
          }
          if (controller.getTransactionsStatus.status == Status.error) {
            return CustomErrorWidget(
              onRefreshPress: () => controller.getTransactions(pageNumber: 1),
            );
          }
          return RefreshIndicator(
            onRefresh: () => controller.getTransactions(pageNumber: 1),
            child: ListView.builder(
              controller: controller.scrollController,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemCount: controller.transactionList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return TransactionItem(
                  transaction: controller.transactionList[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
