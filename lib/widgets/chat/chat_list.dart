import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/chat_controller.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/themes/app_font.dart';

import '../global/profile_picture.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();
    return controller.contacts.isEmpty
        ? const Center(
            child: Text("No chats", style: TextStyle(color: Colors.grey)))
        : ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: controller.chats.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  controller.selectedContactChat =
                      controller.chats[index].users![1];
                  controller.selectedChat = controller.chats[index];
                  Get.toNamed(RouteName.chatRoom);
                },
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  width: Get.width,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ProfilePicture(
                                size: 50,
                                imageURL:
                                    controller.chats[index].users![1].photoUrl),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      controller
                                          .chats[index].users![1].displayName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppFont.text16.copyWith(
                                          fontWeight: FontWeight.bold)),
                                  Expanded(
                                    child: Text(
                                        controller.chats[index].lastMessage,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppFont.text12
                                            .copyWith(color: Colors.grey)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(controller.chats[index].lastMessageTime!,
                              style:
                                  AppFont.text12.copyWith(color: Colors.grey)),
                          const SizedBox(height: 3),
                          Container(
                            height: 16,
                            width: 16,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.primaryColor),
                            child: Center(
                              child: Text(
                                "3",
                                style: AppFont.text10
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
  }
}
