import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/widgets/global/line.dart';
import 'package:upmatev2/widgets/global/title_section.dart';
import 'package:upmatev2/widgets/notification/follow.dart';
import 'package:upmatev2/widgets/notification/post.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            TitleSection(title: "Baru"),
            Follow(),
            Follow(),
            Follow(),
            Line(),
            SizedBox(
              height: 10,
            ),
            TitleSection(title: "Hari ini"),
            SizedBox(
              height: 5,
            ),
            Post(),
            Post(),
            Post(),
            Line(),
            SizedBox(
              height: 10,
            ),
            TitleSection(title: "Kemarin"),
            Post(),
            Post(),
            Post(),
            Post(),
            Post(),
          ],
        ),
      ),
      Positioned(
        top: 0,
        child: Container(
          color: Colors.white,
          width: Get.width,
          child: const SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Notification",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.more_vert_rounded,
                        size: 28,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
                Line()
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
