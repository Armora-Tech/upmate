import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/post_detail_controller.dart';
import '../../controllers/start_controller.dart';
import '../../models/post_model.dart';
import '../../themes/app_color.dart';
import '../../themes/app_font.dart';
import '../global/emoji_section.dart';
import '../global/profile_picture.dart';

class PostDetailTypeComment extends StatelessWidget {
  final PostModel post;
  const PostDetailTypeComment({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final startController = Get.find<StartController>();
    final controller = Get.find<PostDetailController>();
    return Positioned(
      bottom: 0,
      width: Get.width,
      child: GetBuilder<PostDetailController>(
        builder: (_) => Column(
          children: [
            Container(
              constraints: const BoxConstraints(maxHeight: 140),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                color: AppColor.primaryColor,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                    bottomLeft: Radius.circular(40),
                                    bottomRight: Radius.circular(8)),
                                color: AppColor.primaryColor),
                            child: ProfilePicture(
                              size: 30,
                              imageURL: startController.user!.photoUrl,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: SingleChildScrollView(
                              child: TextField(
                                focusNode: controller.focusNode,
                                style: AppFont.text16,
                                controller: controller.textEditingController,
                                maxLines: null,
                                onChanged: (text) {
                                  text.isNotEmpty
                                      ? controller.isTextFieldEmpty.value =
                                          false
                                      : controller.isTextFieldEmpty.value =
                                          true;
                                  controller.update();
                                },
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: "type_a_comment".tr,
                                  hintStyle: AppFont.text14.copyWith(
                                    color: Colors.grey,
                                    fontFamily: "Nunito",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: controller.isTextFieldEmpty.value
                          ? GestureDetector(
                              onTap: () {
                                controller.isShowEmoji.toggle();
                                controller.focusNode.unfocus();
                                controller.update();
                              },
                              child: Icon(
                                  controller.isShowEmoji.value
                                      ? Icons.emoji_emotions_rounded
                                      : Icons.emoji_emotions_outlined,
                                  size: 28),
                            )
                          : GestureDetector(
                              onTap: () async =>
                                  await controller.addComment(post),
                              child: const Icon(Icons.send_rounded, size: 28),
                            ),
                    )
                  ],
                ),
              ),
            ),
            controller.isShowEmoji.value
                ? EmojiSection(controller: controller)
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
