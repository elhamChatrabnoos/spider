import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sockettest/app/config/app_assets.dart';
import 'package:sockettest/features/home/controllers/record_voice_controller.dart';

class RecordSoundDialog extends StatelessWidget {
  RecordSoundDialog({super.key});

  final controller = Get.put(RecordVoiceController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(fontSize: 18, color: Colors.black),
      contentPadding: EdgeInsets.all(20),
      content: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          controller.startListening();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 40),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.6),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary,
                      spreadRadius: 12,
                      blurRadius: 16,
                      offset: const Offset(1, 1),
                    ),
                  ]),
              child: Image.asset(
                AppAssets.blackLogo,
                color: Colors.black,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
