import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../controllers/start_controller.dart';
import '../../themes/app_font.dart';

class LikesButton extends StatelessWidget {
  final List<dynamic> likes;
  const LikesButton({super.key, required this.likes});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final startController = Get.find<StartController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
            !controller.isLoading.value &&
                    likes.contains(startController.user!.uid)
                ? "assets/svg/favorite.svg"
                : "assets/svg/favorite_outlined.svg",
            semanticsLabel: 'favorite',
            height: 27,
            width: 27),
        const SizedBox(height: 2),
        Text("${controller.isLoading.value ? 0 : likes.length}",
            style: AppFont.text10)
      ],
    );
  }
}
