import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBookmark extends StatelessWidget {
  const MyBookmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      width: Get.width,
      alignment: Alignment.topCenter,
      child: Text(
        "no_posts_saved".tr,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
