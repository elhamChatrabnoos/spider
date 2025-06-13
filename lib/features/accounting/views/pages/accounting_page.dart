import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sockettest/app/network/request_status.dart';
import 'package:sockettest/app/widgets/error_widget.dart';
import 'package:sockettest/app/widgets/my_progress_indicator_widget.dart';
import 'package:sockettest/features/accounting/controllers/accounting_page_controller.dart';
import 'package:sockettest/features/accounting/views/widgets/add_edit_accounting_dialog.dart';
import 'package:sockettest/features/accounting/views/widgets/box_widget.dart';
import 'package:sockettest/features/accounting/views/widgets/transaction_item.dart';
import 'package:sockettest/features/accounts/controllers/accounts_page_controller.dart';

class AccountingPage extends GetView<AccountingPageController> {
  const AccountingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AccountingPageController());
    Get.put(AccountsPageController());
    controller.getTransactions(pageNumber: 1);
    controller.getTotalInfo();
    return Scaffold(
      appBar: AppBar(
        title: Text('Accounting'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
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
      body: RefreshIndicator(
        onRefresh: () {
          controller.getTotalInfo();
          return controller.getTransactions(pageNumber: 1);
        },
        child: GetBuilder<AccountingPageController>(
            id: controller.transactionsUpdateKey,
            builder: (logic) {
              if (controller.getTransactionsStatus.status == Status.loading) {
                return Center(child: MyProgressIndicator());
              }
              if (controller.getTransactionsStatus.status == Status.error) {
                return CustomErrorWidget(
                  onRefreshPress: () =>
                      controller.getTransactions(pageNumber: 1),
                );
              }
              return SingleChildScrollView(
                controller: controller.scrollController,
                child: Column(
                  children: [
                    _buildTotalInfo(context),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      itemCount: controller.transactionList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return TransactionItem(
                          transaction: controller.transactionList[index],
                        );
                      },
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget _buildTotalInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GetBuilder<AccountingPageController>(
        id: controller.getTotalInfoUpdateKey,
        builder: (logic) {
          if (controller.getTotalInfoStatus.status == Status.loading) {
            return CircularProgressIndicator();
          }
          if (controller.getTotalInfoStatus.status == Status.error) {
            return IconButton(
              onPressed: () => logic.getTotalInfo(),
              icon: Icon(Icons.refresh),
              color: Theme.of(context).primaryColor,
            );
          }
          return Column(
            spacing: 10,
            children: [
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: BoxWidget(
                        boxColor: Colors.grey,
                        title: 'Costs',
                        value: logic.totalInfo.allExpense),
                  ),
                  Expanded(
                    child: BoxWidget(
                        boxColor: Colors.grey,
                        title: 'Balance',
                        value: logic.totalInfo.balance),
                  )
                ],
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: BoxWidget(
                      boxColor: Colors.red,
                      title: 'Hossein',
                      value: logic.totalInfo.hosseinExpenses,
                      icon: Icon(
                        Icons.arrow_circle_up,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Expanded(
                    child: BoxWidget(
                      boxColor: Colors.grey,
                      title: 'Loans',
                      value: logic.totalInfo.hosseinLoan,
                      icon: Icon(
                        Icons.credit_card,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: BoxWidget(
                      boxColor: Colors.green,
                      title: 'Hossein',
                      value: logic.totalInfo.hosseinDeposit,
                      icon: Icon(
                        Icons.arrow_circle_down,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: BoxWidget(
                      boxColor: Colors.green,
                      title: 'Elham',
                      value: logic.totalInfo.elhamDeposit,
                      icon: Icon(
                        Icons.arrow_circle_down,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Expanded(
                    child: BoxWidget(
                      boxColor: Colors.grey,
                      title: 'Loans',
                      value: logic.totalInfo.elhamLoan,
                      icon: Icon(
                        Icons.credit_card,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: BoxWidget(
                      boxColor: Colors.red,
                      title: 'Elham',
                      value: logic.totalInfo.eliExpenses,
                      icon: Icon(
                        Icons.arrow_circle_up,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
