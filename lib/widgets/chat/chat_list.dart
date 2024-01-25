import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/chat_controller.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/themes/app_font.dart';

import '../../repositories/auth.dart';
import '../global/profile_picture.dart';

class ChatList extends StatelessWidget {
  ChatList({super.key});

  final ChatController _chatController = ChatController();
  final Auth _auth = Auth();
  late final User? user = _auth.getUser();
  late List<String> title;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: 15,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 20);
      },
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Get.toNamed(RouteName.chatRoom),
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
                      const ProfilePicture(size: 50),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Muhammad Rafli Silehu",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppFont.text16
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(
                                "Hallo kak perkenalkan nama saya perkenalkan lorem ipsum manual 123 tes tes 321 12345 processMotionEvent MotionEvent { action=ACTION_UP, actionButton=0, id[0]=0, x[0]=785.0, y[0]=2145.0, toolType[0]=TOOL_TYPE_FINGER.",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    AppFont.text12.copyWith(color: Colors.grey),
                              ),
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
                    Text("3:16 pm",
                        style: AppFont.text12.copyWith(color: Colors.grey)),
                    const SizedBox(height: 3),
                    Container(
                      height: 16,
                      width: 16,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.primaryColor,
                      ),
                      child: Center(
                        child: Text(
                          "3",
                          style: AppFont.text10.copyWith(color: Colors.white),
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
