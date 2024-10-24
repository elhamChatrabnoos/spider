import 'package:flutter/material.dart';
import 'package:sockettest/features/accounting/views/widgets/accounting_item.dart';
import 'package:sockettest/features/accounting/views/widgets/add_edit_accounting_dialog.dart';

class AccountingPage extends StatelessWidget {
  const AccountingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accounting'),
        backgroundColor: Theme.of(context).primaryColor,
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
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          itemCount: 10,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return AccountingItem();
          },
        ),
      ),
    );
  }
}
