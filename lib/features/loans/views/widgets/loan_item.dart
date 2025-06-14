import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sockettest/app/config/app_theme.dart';
import 'package:sockettest/app/widgets/custom_button.dart';
import 'package:sockettest/app/widgets/row_info_widget.dart';
import 'package:sockettest/app/widgets/user_name_widget.dart';
import 'package:sockettest/features/loans/models/loans_response.dart';

class LoanItem extends StatelessWidget {
  const LoanItem({super.key, required this.loanItem});

  final LoanModel loanItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        spacing: 10,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RowInfoWidget(
                      title: 'Mobile',
                      value: '',
                      textStyle: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 1),
                    RowInfoWidget(
                      icon: Icon(
                        Icons.request_page_outlined,
                        color: Theme.of(context).colorScheme.onSecondary,
                        size: 20,
                      ),
                      title: '',
                      value: NumberFormat('#,##0', 'en_US')
                          .format(2000)
                          .toString(),
                    ),
                    RowInfoWidget(
                      title: '',
                      value: '12/12/2012',
                      icon: Icon(
                        Icons.access_alarm,
                        color: Theme.of(context).colorScheme.onSecondary,
                        size: 20,
                      ),
                    ),
                    RowInfoWidget(
                      title: '',
                      value: 'Elham',
                      icon: Icon(
                        Icons.account_circle_outlined,
                        color: Theme.of(context).colorScheme.onSecondary,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomButton(
                      width: 0,
                      height: 35,
                      text: 'Payment',
                      borderRadius: 50,
                      buttonColor: AppTheme.green.withValues(alpha: 0.3),
                      textSize: 12,
                    ),
                    CustomButton(
                      width: 0,
                      height: 35,
                      text: 'Settlement',
                      borderRadius: 50,
                      buttonColor: AppTheme.orange.withValues(alpha: 0.4),
                      textSize: 12,
                    ),
                  ],
                ),
              ),
              // UserNameWidget(userName: 'elham'),
            ],
          ),
        ],
      ),
    );
  }
}
