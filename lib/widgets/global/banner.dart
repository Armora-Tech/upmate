import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/profile_controller.dart';
import 'package:upmatev2/controllers/start_controller.dart';

import '../../themes/app_color.dart';

class MyBanner extends StatelessWidget {
  final String? otherUserPhoto;
  const MyBanner({super.key, this.otherUserPhoto});

  @override
  Widget build(BuildContext context) {
    final startController = Get.find<StartController>();
    final controller = Get.find<ProfileController>();
    return Container(
      height: Get.width * 9 / 16,
      width: Get.width,
      decoration: const BoxDecoration(color: AppColor.primaryColor),
      child: controller.otherUser.bannerUrl == null
          ? const SizedBox()
          : Image.network(otherUserPhoto ?? startController.user!.bannerUrl!,
              fit: BoxFit.cover),
    );
  }
}
