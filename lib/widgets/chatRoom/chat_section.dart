import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:upmatev2/controllers/chat_room_controller.dart';

import '../../themes/app_color.dart';
import '../../themes/app_font.dart';
import '../global/detail_image.dart';

class ChatRoomChatSection extends StatelessWidget {
  const ChatRoomChatSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatRoomController>();
    return ListView.separated(
      padding:
          const EdgeInsets.only(left: 10, right: 10, top: 120, bottom: 100),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      reverse: true,
      itemCount: controller.chats.length,
      separatorBuilder: (context, index) => const SizedBox(height: 2),
      itemBuilder: (context, index) {
        controller.setMargin(index);
        return SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: controller.isUser(index)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: controller.marginTop.value,
                    bottom: controller.marginBottom.value),
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.chats[index].text is File)
                        GestureDetector(
                          onTap: () => Get.to(
                              () => DetailImage(
                                  image: controller.chats[index].text),
                              opaque: false,
                              fullscreenDialog: true,
                              transition: Transition.noTransition),
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            constraints: BoxConstraints(
                                maxWidth: Get.width * 0.8,
                                minHeight: 180,
                                maxHeight: 350),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: Hero(
                              tag: controller.chats[index].text.toString() +
                                  DateTime.now().toString(),
                              child: Image.file(
                                File(controller.chats[index].text),
                                gaplessPlayback: true,
                              ),
                            ),
                          ),
                        )
                      // else if (controller.chats[index].text
                      //     is AssetEntity)
                      //   GestureDetector(
                      //     onTap: () => Get.to(
                      //         () => DetailImage(
                      //               image: controller
                      //                   .chats[index].text,
                      //             ),
                      //         opaque: false,
                      //         fullscreenDialog: true,
                      //         transition: Transition.noTransition),
                      //     child: Container(
                      //       clipBehavior: Clip.hardEdge,
                      //       constraints: BoxConstraints(
                      //           maxWidth: Get.width * 0.8,
                      //           minHeight: 180,
                      //           maxHeight: 350),
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(15)),
                      //       child: Hero(
                      //         tag: controller.chats[index].text
                      //                 .toString() +
                      //             DateTime.now().toString(),
                      //         child: AssetEntityImage(

                      //           fit: BoxFit.cover,
                      //         ),
                      //       ),
                      //     ),
                      //   )
                      else
                        Container(
                          constraints:
                              BoxConstraints(maxWidth: Get.width * 0.7),
                          alignment: controller.isUser(index)
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 7),
                          decoration: BoxDecoration(
                              color: controller.isUser(index)
                                  ? Colors.white
                                  : AppColor.primaryColor,
                              border: controller.isUser(index)
                                  ? Border.all(
                                      width: 1,
                                      color: const Color.fromARGB(
                                          255, 144, 172, 183))
                                  : Border.all(width: 0),
                              borderRadius:
                                  controller.checkPositionedUserChat(index)),
                          child: Column(
                            children: [
                              Text(
                                controller.chats[index].text,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    color: controller.isUser(index)
                                        ? Colors.black
                                        : Colors.white),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                      "${controller.chats[index].timestamp.hour}:${controller.chats[index].timestamp.minute.toString().padLeft(2, '0')}",
                                      style: AppFont.text10
                                          .copyWith(color: Colors.grey)),
                                  const SizedBox(width: 3),
                                  const Icon(Icons.check_rounded,
                                      color: Colors.grey, size: 16)
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
