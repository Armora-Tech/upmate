import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/profile_controller.dart';
import 'package:upmatev2/widgets/global/line.dart';

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return SizedBox(
      width: Get.width,
      height: 50,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => controller.selectTab(0),
                child: Container(
                  color: Colors.white,
                  width: Get.width / 2,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(Icons.grid_view_outlined, size: 28),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => controller.selectTab(1),
                child: Container(
                  color: Colors.white,
                  width: Get.width / 2,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(Icons.bookmark_outline_outlined, size: 28),
                  ),
                ),
              )
            ],
          ),
          const Positioned(bottom: 0, child: Line()),
          GetBuilder<ProfileController>(
            builder: (_) => AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: controller.selectedTab.value == 0 ? 0 : Get.width / 2,
              bottom: 0,
              child: Container(
                  height: 1.5, width: Get.width / 2, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
