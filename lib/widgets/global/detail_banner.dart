import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/start_controller.dart';

class DetailBanner extends StatelessWidget {
  final String? otherUserPhoto;
  const DetailBanner({super.key, this.otherUserPhoto});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StartController>();
    return GestureDetector(
      onTap: () => Get.back(),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.3),
        body: Center(
          child: Hero(
            tag: "detail_banner",
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                width: Get.width,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(color: Colors.grey),
                child: Image.network(
                  otherUserPhoto ?? controller.user!.bannerUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
