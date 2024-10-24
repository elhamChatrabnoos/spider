import 'package:flutter/material.dart';

import 'custom_text.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, required this.errorMsg});

  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.close, color: Colors.red, size: 50),
          CustomText(text: 'Error'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: CustomText(text: errorMsg),
          ),
        ],
      ),
      actions: [
        CustomText(onClickText: () => Navigator.pop(context), text: 'Close')
      ],
    );
  }
}
