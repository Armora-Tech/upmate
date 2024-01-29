import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../models/comment_model.dart';
import '../../themes/app_font.dart';

class CommentButton extends StatelessWidget {
  final List<CommentModel> comments;
  const CommentButton({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/svg/comment.svg",
            height: 27, width: 27, semanticsLabel: 'comment'),
        const SizedBox(height: 2),
        Text("${controller.isLoading.value ? 0 : comments.length}",
            style: AppFont.text10)
      ],
    );
  }
}
