import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/edit_profile_controller.dart';
import '../controllers/camera_controller.dart';

class CameraView extends StatelessWidget {
  final String? routeName;
  final bool isCrop;
  const CameraView({super.key, this.routeName, this.isCrop = false});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CameraViewController>();
    final editProfileController = Get.find<EditProfileController>();
    return GetBuilder<CameraViewController>(
        builder: (_) => WillPopScope(
            onWillPop: () async {
              await controller.outOfCamera();
              return Future.value(false);
            },
            child: Scaffold(
              backgroundColor: const Color.fromARGB(255, 15, 22, 25),
              body: Container(
                color: const Color.fromARGB(255, 15, 22, 25),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: SizedBox(
                    width: Get.width,
                    child: Stack(
                      children: [
                        SafeArea(
                          child: Container(
                              width: Get.width,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: CameraPreview(
                                controller.cameraController,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: GestureDetector(
                                      onTap: () async =>
                                          await controller.outOfCamera(),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                        Positioned(
                          bottom: 0,
                          width: Get.width,
                          child: Container(
                            height: 80,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(97, 32, 45, 50),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () async => await controller
                                      .onSetFlashModeButtonPressed(),
                                  child: SizedBox(
                                    height: 45,
                                    width: 45,
                                    child: Icon(
                                      controller.isFlashOn.value
                                          ? Icons.flash_on
                                          : Icons.flash_off,
                                      color: Colors.white,
                                      size: 26,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: controller.isTakingPicture.value
                                      ? () {}
                                      : isCrop
                                          ? () async => await controller
                                              .takePictureWithCrop(
                                                  editProfileController
                                                      .isEditBanner.value)
                                          : () async => await controller
                                              .takePicture(routeName!),
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 3.5, color: Colors.white)),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async =>
                                      await controller.swicthCamera(),
                                  child: const SizedBox(
                                    height: 45,
                                    width: 45,
                                    child: Icon(
                                      Icons.flip_camera_ios,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
