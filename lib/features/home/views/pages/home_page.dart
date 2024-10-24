import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sockettest/app/config/app_assets.dart';
import 'package:sockettest/features/home/views/widgets/main_list_widget.dart';
import 'package:sockettest/features/home/views/widgets/record_sound_diaolog.dart';

import '../../controllers/home_page_controller.dart';
import '../widgets/custom_text.dart';
import '../widgets/history_dialog.dart';

class HomePage extends GetView<HomePageController> {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomePageController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            Theme.of(context).colorScheme.secondary.withOpacity(0.8),
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
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        title: Row(
          children: [
            Column(
              children: [
                Opacity(
                    opacity: 0.8,
                    child: Image.asset(
                      AppAssets.whiteLogo,
                      width: 30,
                      height: 30,
                    )),
                SizedBox(height: 3),
              ],
            ),
            const Spacer(),
            Obx(() {
              return Text(
                controller.isSocketConnect.value ? 'Connect' : 'Disconnect',
                style: TextStyle(
                  fontSize: 20,
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(AppAssets.whiteLogo,
                  opacity: AlwaysStoppedAnimation(.1)),
              Padding(
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
                              backgroundColor: Color(0xFF383838),
                              context: context,
                              builder: (context) {
                                return const HistoryDialog();
                              },
                            );
                          },
                          text: 'show history',
                          fontColor: Colors.white.withOpacity(0.5),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(child: MainListWidget()),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
