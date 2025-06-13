import 'package:flutter/material.dart';

class RowInfoWidget extends StatelessWidget {
  const RowInfoWidget({
    super.key,
    required this.title,
    required this.value,
    this.textStyle,
    this.icon,
  });

  final String title;
  final String value;
  final TextStyle? textStyle;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon ?? SizedBox(),
        Text('$title ',
            style: textStyle ??
                Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontWeight: FontWeight.w500)),
        Expanded(
          child: Text(
              overflow: TextOverflow.ellipsis,
              value,
              style: Theme.of(context).textTheme.bodySmall),
        ),
      ],
    );
  }
}
