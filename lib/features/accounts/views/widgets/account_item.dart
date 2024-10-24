import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sockettest/features/accounts/models/get_account_response.dart';

class AccountItem extends StatelessWidget {
  const AccountItem({super.key, required this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 12,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.account_box, size: 50, color: Theme.of(context).colorScheme.onPrimary,),
          SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRow(context, 'Name', account.name),
                SizedBox(height: 10),
                _buildRow(
                  context,
                  'Balance',
                  NumberFormat('#,##0', 'en_US')
                      .format(account.balance)
                      .toString(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, title, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('$title: ', style: Theme.of(context).textTheme.titleSmall),
        SizedBox(width: 5),
        Expanded(
            child: Text(
                overflow: TextOverflow.ellipsis,
                value,
                style: Theme.of(context).textTheme.bodySmall)),
      ],
    );
  }
}
