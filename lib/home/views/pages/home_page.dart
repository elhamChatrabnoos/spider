import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sockettest/app/config/app_colors.dart';
import 'package:sockettest/app/config/app_helper.dart';
import 'package:sockettest/home/views/widgets/main_list_widget.dart';
import 'package:sockettest/home/views/widgets/record_sound_diaolog.dart';

import '../../controllers/home_page_controller.dart';
import '../widgets/custom_text.dart';
import '../widgets/history_dialog.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    controller.socketListeners();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return RecordSoundDialog();
            },
          ).then(
            (value) {
              if (value != null) {
                AppHelper.log.w('value after close dialog : $value');
                controller.sendVoiceToServer(value);
              }
            },
          );
        },
        child: Icon(
          Icons.mic,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.4),
        title: Row(
          children: [
            Text(
              'Spider',
              style: TextStyle(
                fontSize: 24,
                color: Colors.amber.withOpacity(0.5),
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Obx(() {
              return Text(
                controller.isSocketConnect.value ? 'Connect' : 'Disconnect',
                style: TextStyle(
                  fontSize: 24,
                  color: controller.isSocketConnect.value
                      ? Colors.green
                      : Colors.redAccent,
                  fontWeight: FontWeight.w600,
                ),
              );
            })
          ],
        ),
      ),
      backgroundColor: Colors.black.withOpacity(0.5),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => controller.reconnectSocket(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomText(
                        onClickText: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.grey,
                            context: context,
                            builder: (context) {
                              return const HistoryDialog();
                            },
                          );
                        },
                        text: 'show history',
                        fontColor: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(child: MainListWidget()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
