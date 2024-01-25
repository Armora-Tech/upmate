import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../themes/app_font.dart';
import '../global/line.dart';
import 'post_action.dart';
import 'post_comment.dart';
import 'post_description.dart';
import 'post_header.dart';
import 'post_image.dart';

class PostSection extends StatelessWidget {
  final int index;
  const PostSection({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Column(
      children: [
        PostHeader(index: index),
        const SizedBox(height: 10),
        PostImage(post: controller.posts![index]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostAction(post: controller.posts![index]),
              const SizedBox(height: 15),
              PostDescription(post: controller.posts![index]),
              const SizedBox(height: 5),
              PostCommentSection(post: controller.posts![index]),
              Text(
                controller.postingTimePassed(controller.posts![index]),
                style: AppFont.text12.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Line(),
      ],
    );
  }
}
