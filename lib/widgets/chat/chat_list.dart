import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/chat_controller.dart';
import 'package:upmatev2/models/chat_model.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_font.dart';
import 'package:upmatev2/widgets/global/users_shimmer.dart';

import '../../repositories/chat_repository.dart';
import '../global/line.dart';
import '../global/profile_picture.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();
    return SizedBox(
      width: Get.width,
      child: StreamBuilder<List<ChatModel>>(
        stream: ChatRepository().getChatsStream(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ChatModel>> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("No chats", style: TextStyle(color: Colors.grey)),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const UsersShimmer();
          }

          return ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              ChatModel data = snapshot.data![index];
              return Padding(
                padding: EdgeInsets.only(
                    bottom: index == snapshot.data!.length - 1 ? 65 : 0),
                child: GestureDetector(
                  onTap: () {
                    controller.selectedContact = data.chatRecipient!;
                    controller.selectedChat = snapshot.data![index];
                    Get.toNamed(RouteName.chatRoom);
                  },
                  child: Column(
                    children: [
                      Container(
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
                                      imageURL: data.chatRecipient!.photoUrl),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(data.chatRecipient!.displayName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppFont.text16.copyWith(
                                                fontWeight: FontWeight.bold)),
                                        Expanded(
                                          child: Text(data.lastMessage,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppFont.text12.copyWith(
                                                  color: Colors.grey)),
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
                                Text(data.lastMessageTime!,
                                    style: AppFont.text12
                                        .copyWith(color: Colors.grey)),
                                const SizedBox(height: 3),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Line()
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
