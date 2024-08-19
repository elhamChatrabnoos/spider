import 'package:flutter/cupertino.dart';
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
          Row(
            children: [
              const CustomText(
                text: 'History',
                fontSize: 25,
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Obx(() {
            return Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.historyList.length,
                itemBuilder: (context, index) {
                  return Container(
                    // padding: EdgeInsets.all(10),
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CustomText(
                      overflow: TextOverflow.clip,
                      text: controller.historyList[index],
                      padding: 10,
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
