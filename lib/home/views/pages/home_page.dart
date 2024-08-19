import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_page_controller.dart';
import '../widgets/custom_text.dart';
import '../widgets/history_dialog.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    controller.connectSocket();
    return Scaffold(
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
                    Expanded(
                      child: Obx(() {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                children: controller.receivedMessage1.map(
                                  (element) {
                                    return Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.amber.withOpacity(0.2),
                                            spreadRadius: 5,
                                            blurRadius: 12,
                                            offset: const Offset(4, 4),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        element,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
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
