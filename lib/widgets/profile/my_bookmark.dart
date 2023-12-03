import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBookmark extends StatelessWidget {
  const MyBookmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      height: 500,
      width: Get.width,
      alignment: Alignment.topCenter,
      child: const Text("Tidak ada postingan yang disimpan", style: TextStyle(color: Colors.grey),),
    );
  }
}