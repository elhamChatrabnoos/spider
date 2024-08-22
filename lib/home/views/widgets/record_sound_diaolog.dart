import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sockettest/home/controllers/record_voice_controller.dart';
import 'package:sockettest/home/views/widgets/custom_text.dart';

class RecordSoundDialog extends StatelessWidget {
  RecordSoundDialog({super.key});

  final controller = Get.put(RecordVoiceController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titleTextStyle: TextStyle(fontSize: 18, color: Colors.black),
      title: Obx(() {
        return CustomText(
          text: controller.listeningStarted.value
              ? 'Voice is recording...'
              : 'Tap to start recording',
          textAlign: TextAlign.center,
          overflow: TextOverflow.clip,
        );
      }),
      contentPadding: EdgeInsets.all(20),
      content: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          controller.startListening();
        },
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: controller.listeningStarted.value
                        ? Colors.amber.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.mic,
                    color: Colors.amber,
                    size: 50,
                  ),
                ),
                SizedBox(height: 10),
                CustomText(
                  text: controller.lastWords.value,
                  overflow: TextOverflow.clip,
                )
              ],
            ),
          );
        }),
      ),
      actions: [
        Obx(() {
          return controller.listeningStarted.value
              ? SizedBox()
              : CustomText(
                  text: 'close',
                  onClickText: () async {
                    Get.back();
                  },
                );
        }),
      ],
    );
  }
}
