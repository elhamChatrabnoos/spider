import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sockettest/app/network/request_status.dart';
import 'package:sockettest/app/network/response_status.dart';
import 'package:sockettest/features/accounts/controllers/accounts_page_controller.dart';
import 'package:sockettest/features/accounts/views/widgets/account_item.dart';
import 'package:sockettest/features/accounts/views/widgets/add_edit_account_dialog.dart';

class AccountsPage extends GetView<AccountsPageController> {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(fenix: true, () => AccountsPageController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Accounts'),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddEditAccountDialog(),
          );
        },
      ),
      body: GetBuilder<AccountsPageController>(
        id: controller.getAccountsUpdateKey,
        builder: (logic) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemCount: controller.accountsList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return AccountItem(account: controller.accountsList[index]);
            },
          );
        },
      ),
    );
  }
}
