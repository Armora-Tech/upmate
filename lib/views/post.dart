import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.grey,
      ),
    );
  }
}