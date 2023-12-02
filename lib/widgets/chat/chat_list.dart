import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_color.dart';

import '../global/profile_picture.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: 15,
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 20,
        );
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
                const Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ProfilePicture(size: 50),
                      SizedBox(
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Expanded(
                              child: Text(
                                "Hallo kak perkenalkan nama saya perkenalkan lorem ipsum manual 123 tes tes 321 12345 processMotionEvent MotionEvent { action=ACTION_UP, actionButton=0, id[0]=0, x[0]=785.0, y[0]=2145.0, toolType[0]=TOOL_TYPE_FINGER.",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
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
                    const Text(
                      "3:16 pm",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Container(
                      height: 15,
                      width: 15,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.primaryColor,
                      ),
                      child: const Center(
                        child: Text(
                          "3",
                          style: TextStyle(fontSize: 9, color: Colors.white),
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
