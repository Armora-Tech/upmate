import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/chat_room_controller.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/widgets/global/profile_picture.dart';

import '../widgets/global/line.dart';

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatRoomController>();
    return Scaffold(
      body: Stack(alignment: Alignment.center, fit: StackFit.expand, children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
          ],
        ),
        Positioned(
          top: 0,
          child: Container(
            color: AppColor.primaryColor,
            width: Get.width,
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => Get.back(),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const ProfilePicture(size: 40),
                              const SizedBox(
                                width: 10,
                              ),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Muhammad Rafli Silehu",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "Online",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Icon(
                            Icons.more_vert_rounded,
                            size: 28,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Line()
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          width: Get.width,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 120),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 3,
                  color: AppColor.shadowColor,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.emoji_emotions_outlined,
                        color: Colors.grey,
                        size: 28,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: SingleChildScrollView(
                          child: TextField(
                            style: const TextStyle(fontSize: 14),
                            controller: controller.textEditingController,
                            maxLines: null,
                            onChanged: (text) {
                              text.isNotEmpty
                                  ? controller.isTextFieldEmpty.value = false
                                  : controller.isTextFieldEmpty.value = true;
                            },
                            decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: "Ketikkan Pesan",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontFamily: "Nunito",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => controller.isTextFieldEmpty.value
                      ? const Row(
                          children: [
                            Icon(
                              Icons.attach_file_outlined,
                              color: Colors.grey,
                              size: 28,
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.grey,
                              size: 28,
                            )
                          ],
                        )
                      : const Icon(
                          Icons.send_rounded,
                          color: Colors.grey,
                          size: 28,
                        ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
