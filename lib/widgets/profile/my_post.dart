import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPost extends StatelessWidget {
  const MyPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      width: Get.width,
      alignment: Alignment.topCenter,
      child: const Text(
        "Tidak ada postingan",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
