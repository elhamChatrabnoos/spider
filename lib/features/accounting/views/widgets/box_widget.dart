import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({
    super.key,
    required this.boxColor,
    required this.title,
    this.value,
    this.icon,
  });

  final Color boxColor;
  final String title;
  final int? value;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      decoration: BoxDecoration(
        color: boxColor.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(title,
                      style: Theme.of(context).textTheme.labelMedium)),
              icon ?? SizedBox(),
            ],
          ),
          Row(
            children: [
              Icon(Icons.attach_money, color: Theme.of(context).colorScheme.onSecondary, size: 15,),
              Text(
                  value == null ? '' : NumberFormat('#,##0', 'en_US').format(value),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}
