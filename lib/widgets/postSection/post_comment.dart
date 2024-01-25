import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:upmatev2/controllers/home_controller.dart';
import 'package:upmatev2/models/post_model.dart';
import 'package:upmatev2/routes/route_name.dart';

import '../../themes/app_font.dart';

class PostCommentSection extends StatelessWidget {
  final PostModel post;
  const PostCommentSection({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final comments = post.comments!.length > 2
        ? post.comments!.sublist(0, 2)
        : post.comments!;
    return post.comments!.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              post.comments!.length > 2
                  ? GestureDetector(
                      onTap: () =>
                          Get.toNamed(RouteName.postDetail, arguments: post),
                      child: Text(
                          "${"see_all".tr} ${post.comments!.length} ${"comment".tr}",
                          style: const TextStyle(color: Colors.grey)),
                    )
                  : const SizedBox(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: comments
                    .map<Widget>(
                      (comment) => Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 25,
                              margin: const EdgeInsets.only(right: 10),
                              clipBehavior: Clip.hardEdge,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: Image.network(comment.user!.photoUrl!,
                                  fit: BoxFit.cover),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: AppFont.text14,
                                      children: [
                                        TextSpan(
                                          text:
                                              "${comment.user!.username.replaceAll("@", "")} ",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: comment.text,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    controller.commentTimePassed(comment),
                                    maxLines: 2,
                                    style: AppFont.text10
                                        .copyWith(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
              post.comments!.isNotEmpty
                  ? const SizedBox(height: 10)
                  : const SizedBox(),
            ],
          )
        : const SizedBox();
  }
}
