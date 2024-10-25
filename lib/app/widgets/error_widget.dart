import 'package:flutter/material.dart';
import 'package:sockettest/app/config/app_text.dart';

import 'custom_button.dart';
import 'custom_text.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, this.errorMsg, this.onRefreshPress});

  final String? errorMsg;
  final Function()? onRefreshPress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
            text: errorMsg ?? AppTexts.serverError,
            fontColor: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 10),
          onRefreshPress != null
              ? CustomButton(
                  buttonColor: Theme.of(context).colorScheme.primary,
                  width: 150,
                  text: 'Try Again',
                  onPressed: onRefreshPress,
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
