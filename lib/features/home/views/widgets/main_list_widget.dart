import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sockettest/features/home/controllers/home_page_controller.dart';

class MainListWidget extends GetView<HomePageController> {
  const MainListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: controller.receivedMessage1.reversed.map(
                (element) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 12,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.receipt_rounded,
                          color: Colors.white.withOpacity(0.5),
                          size: 30,
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            element,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      );
    });
  }
}
