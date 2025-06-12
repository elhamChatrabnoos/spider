import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({
    super.key,
    required this.boxColor,
    required this.title,
    this.value,
  });

  final Color boxColor;
  final String title;
  final int? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: boxColor.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 10,
        children: [
          Text(title, style: Theme.of(context).textTheme.labelMedium),
          Text(
              value == null ? '' : NumberFormat('#,##0', 'en_US').format(value),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10)),
        ],
      ),
    );
  }
}
