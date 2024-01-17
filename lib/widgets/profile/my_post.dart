import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/profile_controller.dart';
import 'package:upmatev2/routes/route_name.dart';

class MyPost extends StatelessWidget {
  const MyPost({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return controller.myPosts.isEmpty
        ? Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                "no_posts".tr,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          )
        : GridView.builder(
            padding: const EdgeInsets.only(top: 2),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.myPosts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(RouteName.postDetail,
                      arguments: controller.myPosts[index]);
                },
                child: Container(
                  height: Get.width / 3,
                  width: Get.width / 3,
                  color: Colors.grey,
                  child: Image.network(
                    controller.myPosts[index].postPhoto![0],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
  }
}
