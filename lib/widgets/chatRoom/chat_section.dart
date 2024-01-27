import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/chat_room_controller.dart';
import 'package:upmatev2/models/chat_message_model.dart';
import 'package:upmatev2/repositories/chat_repository.dart';

import '../../controllers/chat_controller.dart';
import '../../themes/app_color.dart';
import '../../themes/app_font.dart';
import '../global/detail_image.dart';

class ChatRoomChatSection extends StatelessWidget {
  const ChatRoomChatSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatRoomController>();
    final chatController = Get.find<ChatController>();
    return SizedBox(
      width: Get.width,
      child: StreamBuilder<QuerySnapshot>(
        stream: ChatRepository()
            .getChatMessagesStream(chatController.selectedChat!.ref),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView.separated(
            padding: const EdgeInsets.only(
                left: 10, right: 10, top: 120, bottom: 100),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            reverse: true,
            itemCount: snapshot.data!.docs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 2),
            itemBuilder: (context, index) {
              ChatMessageModel data =
                  snapshot.data!.docs[index].data()! as ChatMessageModel;
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
                            data.image != null
                                ? GestureDetector(
                                    onTap: () => Get.to(
                                        () => DetailImage(
                                            image: data.image.toString()),
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Hero(
                                        tag: data.image.toString() +
                                            DateTime.now().toString(),
                                        child: Image.network(data.image!,
                                            gaplessPlayback: true,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  )
                                : Container(
                                    constraints: BoxConstraints(
                                        maxWidth: Get.width * 0.7),
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
                                        borderRadius: controller
                                            .checkPositionedUserChat(index)),
                                    child: Column(
                                      children: [
                                        Text(
                                          data.text,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              color: controller.isUser(index)
                                                  ? Colors.black
                                                  : Colors.white),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                                "${controller.chats[index].timestamp.hour}:${controller.chats[index].timestamp.minute.toString().padLeft(2, '0')}",
                                                style: AppFont.text10.copyWith(
                                                    color: Colors.grey)),
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
        },
      ),
    );
  }
}
