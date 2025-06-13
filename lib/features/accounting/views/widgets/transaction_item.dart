import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sockettest/app/config/app_helper.dart';
import 'package:sockettest/app/widgets/row_info_widget.dart';
import 'package:sockettest/app/widgets/user_name_widget.dart';
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
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.onTertiary.withValues(alpha: 0.2),
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
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserNameWidget(userName: transaction.user?.name ?? ''),
                  SizedBox(height: 10),
                  RowInfoWidget(
                    title: 'Amount:',
                    value: NumberFormat('#,##0', 'en_US')
                        .format(transaction.amount)
                        .toString(),
                  ),
                  SizedBox(height: 10),
                  RowInfoWidget(title: 'Reason:',value: transaction.cause?.causes ?? ''),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  transaction.type?.toLowerCase() == 'deposit'
                      ? Icons.arrow_circle_down
                      : Icons.arrow_circle_up,
                  color: transaction.type?.toLowerCase() == 'deposit'
                      ? Colors.green
                      : Colors.red,
                ),
                Spacer(),
                Text(
                  AppHelper.changeUtcToShamsiDateTime(transaction.createdAt),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }



}
