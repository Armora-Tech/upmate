// ignore_for_file: must_be_immutable

import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:upmatev2/controllers/zoom_image_controller.dart';

class DetailImage extends StatelessWidget {
  final dynamic image;

  const DetailImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ZoomImageController());
    return GestureDetector(
      onTap: () => Get.back(),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(165, 0, 0, 0),
        body: Center(
          child: Hero(
            tag: "zoom_post",
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Obx(
                () => InteractiveViewer(
                  transformationController: controller.transformationController,
                  panEnabled: false,
                  clipBehavior: Clip.none,
                  minScale: controller.minScale.value,
                  maxScale: controller.maxScale.value,
                  onInteractionEnd: (details) => controller.resetZoom(),
                  child: (image is AssetEntity)
                      ? Container(
                          constraints:
                              BoxConstraints(maxHeight: Get.height * 0.7),
                          width: Get.width,
                          child: AssetEntityImage(
                            image,
                            fit: BoxFit.contain,
                          ),
                        )
                      : (image is File)
                          ? Container(
                              constraints:
                                  BoxConstraints(maxHeight: Get.height * 0.7),
                              width: Get.width,
                              child: Image.file(
                                image,
                                fit: BoxFit.contain,
                                scale: 4.5,
                              ),
                            )
                          : Image.asset(
                              image,
                              fit: BoxFit.contain,
                            ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
