import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/camera_controller.dart';
import 'package:upmatev2/controllers/chat_room_controller.dart';
import 'package:upmatev2/themes/app_font.dart';

class ConfirmSendImageView extends StatelessWidget {
  const ConfirmSendImageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CameraViewController>();
    final chatRoomController = Get.find<ChatRoomController>();
    return WillPopScope(
      onWillPop: () async {
        controller.image!.deleteSync();
        Get.back();
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 15, 22, 25),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Container(
                    width: Get.width,
                    clipBehavior: Clip.hardEdge,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Image.file(controller.image!, fit: BoxFit.contain),
                  ),
                  Positioned(
                    top: 0,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: GestureDetector(
                          onTap: () {
                            controller.image!.deleteSync();
                            Get.back();
                          },
                          child: const Icon(Icons.close,
                              color: Colors.white, size: 28),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              IntrinsicWidth(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () =>
                      controller.sendImageCamera(chatRoomController.chats),
                  child: Row(
                    children: [
                      Text(
                        "send_picture".tr,
                        style: AppFont.text14.copyWith(
                            color: Colors.white, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.send_rounded,
                          color: Colors.white, size: 18),
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
