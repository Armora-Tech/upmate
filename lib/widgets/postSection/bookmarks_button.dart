import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../controllers/start_controller.dart';
import '../../themes/app_font.dart';

class BookmarksButton extends StatelessWidget {
  final List<dynamic> bookmarks;
  const BookmarksButton({super.key, required this.bookmarks});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final startController = Get.find<StartController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
            !controller.isLoading.value &&
                    bookmarks.contains(startController.user!.uid)
                ? "assets/svg/bookmark.svg"
                : "assets/svg/bookmark_outlined.svg",
            height: 27,
            width: 27,
            semanticsLabel: 'bookmark'),
        const SizedBox(height: 2),
        Text("${controller.isLoading.value ? 0 : bookmarks.length}",
            style: AppFont.text10)
      ],
    );
  }
}
