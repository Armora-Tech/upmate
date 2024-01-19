import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/start_controller.dart';

import '../../themes/app_color.dart';

class MyBanner extends StatelessWidget {
  const MyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final startController = Get.find<StartController>();
    return Container(
        height: Get.width * 9 / 16,
        width: Get.width,
        decoration: const BoxDecoration(color: AppColor.primaryColor),
        child: startController.user!.bannerUrl == null
            ? const SizedBox()
            : Image.network(
                startController.user!.bannerUrl!,
                fit: BoxFit.cover,
              ));
  }
}
