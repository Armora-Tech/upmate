import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/chat_room_controller.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatRoomController>();
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 32, 45, 50),
        body: Container(
          color: const Color.fromARGB(255, 32, 45, 50),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: SafeArea(
              child: SizedBox(
                height: Get.height,
                width: Get.width,
                child: GetBuilder<ChatRoomController>(
                  builder: (_) => Column(
                    children: [
                      Container(
                          height: Get.height - 133,
                          width: Get.width,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: CameraPreview(controller.cameraController)),
                      Container(
                        height: 100,
                        color: const Color.fromARGB(255, 32, 45, 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  controller.onSetFlashModeButtonPressed(),
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
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 3.5, color: Colors.white)),
                            ),
                            GestureDetector(
                              onTap: () async => controller.swicthCamera(),
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
