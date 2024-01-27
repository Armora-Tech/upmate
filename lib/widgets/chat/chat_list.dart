import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/chat_controller.dart';
import 'package:upmatev2/models/chat_model.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/themes/app_font.dart';

import '../../repositories/chat_repository.dart';
import '../global/profile_picture.dart';
import '../global/skelton.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();
    return controller.contacts.isEmpty
        ? const Center(
            child: Text("No chats", style: TextStyle(color: Colors.grey)))
        : SizedBox(
            width: Get.width,
            child: StreamBuilder<QuerySnapshot>(
              stream: ChatRepository().getChatsStream(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child:
                        Text("No chats", style: TextStyle(color: Colors.grey)),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: List.generate(
                        4,
                        (index) => Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          width: Get.width,
                          height: 50,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ShimmerSkelton(
                                        height: 50, width: 50, isCircle: true),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ShimmerSkelton(
                                              height: 15, width: 150),
                                          SizedBox(height: 5),
                                          ShimmerSkelton(height: 8, width: 70),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                // if (snapshot.hasData) {
                //   for (var i in snapshot.data!.docs) {
                //     debugPrint("hallo");
                //     final data = i.data() as ChatModel;
                //     data.initUsers();
                //     debugPrint("hallo ${data.users?[1].displayName}");
                //   }
                // }
                return ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.docs.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    ChatModel data =
                        snapshot.data!.docs[index].data()! as ChatModel;

                    return GestureDetector(
                      onTap: () {
                        controller.selectedContactChat =
                            controller.chats[index].users![1];
                        controller.selectedChat =
                            snapshot.data!.docs[index].data() as ChatModel;
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
                                      imageURL: controller
                                          .chats[index].users![1].photoUrl),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            controller.chats[index].users![1]
                                                .displayName,
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
              },
            ),
          );
  }
}
