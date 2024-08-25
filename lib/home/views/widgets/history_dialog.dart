import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_page_controller.dart';
import 'custom_text.dart';

class HistoryDialog extends GetView<HomePageController> {
  const HistoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getHistoryList();
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const CustomText(
                  text: 'History',
                  fontSize: 25,
                  fontColor: Colors.white,
                ),
                // const Spacer(),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: InkWell(
                //     onTap: () => Get.back(),
                //     child: const Icon(
                //       Icons.dangerous_outlined,
                //       color: Colors.red,
                //       size: 30,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Obx(() {
            return Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.historyList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CustomText(
                      overflow: TextOverflow.clip,
                      text: controller.historyList[index],
                      padding: 10,
                      fontColor: Colors.white,
                    ),
                  );
                },
              ),
            );
          })
        ],
      ),
    );
  }
}
