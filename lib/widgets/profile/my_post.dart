import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/routes/route_name.dart';

class MyPost extends StatelessWidget {
  const MyPost({super.key});

  @override
  Widget build(BuildContext context) {
    final startController = Get.find<StartController>();
    final userPosts = startController.user!.posts ?? [];
    return userPosts.isEmpty
        ? const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                "Tidak ada postingan",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )
        : GridView.builder(
            padding: const EdgeInsets.only(top: 2),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: userPosts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Get.toNamed(RouteName.postDetail),
                child: Container(
                  height: Get.width / 3,
                  width: Get.width / 3,
                  color: Colors.grey,
                ),
              );
            },
          );
  }
}
