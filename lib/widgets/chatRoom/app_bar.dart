import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/chat_controller.dart';

import '../../routes/route_name.dart';
import '../../themes/app_color.dart';
import '../../themes/app_font.dart';
import '../global/line.dart';
import '../global/profile_picture.dart';

class ChatRoomAppBar extends StatelessWidget {
  const ChatRoomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final chatController = Get.find<ChatController>();
    return Positioned(
      top: 0,
      child: Container(
        color: AppColor.primaryColor,
        width: Get.width,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: const Icon(Icons.arrow_back,
                                color: Colors.white, size: 25),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(RouteName.profile, arguments: {
                                  "otherUser": chatController.selectedContact!
                                });
                              },
                              child: Row(
                                children: [
                                  ProfilePicture(
                                      size: 40,
                                      imageURL: chatController
                                          .selectedContact!.photoUrl),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          chatController
                                              .selectedContact!.displayName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "online".tr,
                                          style: AppFont.text12.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Icon(Icons.more_vert_rounded, color: Colors.white),
                    )
                  ],
                ),
              ),
              const Line()
            ],
          ),
        ),
      ),
    );
  }
}
