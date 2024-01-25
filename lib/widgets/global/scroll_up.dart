import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/gallery_controller.dart';
import 'package:upmatev2/themes/app_font.dart';

class ScrollUp extends StatelessWidget {
  final GalleryController controller;
  const ScrollUp({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GalleryController>(
      builder: (_) => AnimatedPositioned(
        duration: const Duration(milliseconds: 300),
        bottom: controller.isBtnShown.value ? 15 : -50,
        child: GestureDetector(
          onTap: () => controller.scrollController.animateTo(0,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOut),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Row(
              children: [
                Text("scroll_up".tr, style: AppFont.text16),
                const SizedBox(width: 5),
                const Icon(Icons.arrow_upward_rounded,
                    size: 20, color: Colors.black),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
