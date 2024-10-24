import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AccountingItem extends StatelessWidget {
  const AccountingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRow(context, 'Account', 'Elham'),
                _buildRow(context, 'Cost', '2000'),
                _buildRow(context, 'Account Balance',
                    NumberFormat('#,##0', 'en_US').format(2000000).toString()),
                _buildRow(context, 'Reason', 'buy clothes'),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Pick',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.green),
                ),
                Text(
                  '02-05-2024',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Theme.of(context).primaryColor),
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
