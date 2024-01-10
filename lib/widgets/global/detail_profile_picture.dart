import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/start_controller.dart';

class DetailProfilePicture extends StatelessWidget {
  const DetailProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StartController>();
    return GestureDetector(
      onTap: () => Get.back(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Hero(
            tag: "detail_profile_picture",
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                height: 250,
                width: 250,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                    color: Colors.grey, shape: BoxShape.circle),
                child: Image.network(
                  controller.user!.photoUrl!,
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
