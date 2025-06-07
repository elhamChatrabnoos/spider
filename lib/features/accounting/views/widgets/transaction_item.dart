import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sockettest/app/config/app_helper.dart';
import 'package:sockettest/features/accounting/models/get_transactions_response.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.onTertiary.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 12,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.account_balance_wallet_outlined,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _userName(context),
                  SizedBox(height: 10),
                  _buildRow(
                    context,
                    'Amount',
                    NumberFormat('#,##0', 'en_US')
                        .format(transaction.amount)
                        .toString(),
                  ),
                  SizedBox(height: 10),
                  _buildRow(context, 'Reason', transaction.cause?.causes),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  transaction.type?.toLowerCase() == 'deposit'
                      ? 'Deposit'
                      : 'Withdraw',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: transaction.type?.toLowerCase() == 'deposit'
                          ? Colors.green
                          : Colors.red),
                ),
                Spacer(),
                Text(
                  AppHelper.changeUtcToShamsiDateTime(transaction.createdAt),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _userName(BuildContext context) {
    bool isHossein = transaction.user?.name?.toLowerCase() == 'hossein';
    Color containerColor = isHossein ? Colors.black : Colors.white;
    Color textColor = isHossein ? Colors.white : Colors.black;

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: containerColor.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        '${transaction.user?.name}',
        style:
            Theme.of(context).textTheme.titleMedium?.copyWith(color: textColor),
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
