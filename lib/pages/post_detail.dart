import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/post_detail_controller.dart';
import 'package:upmatev2/widgets/postSection/post_action.dart';
import 'package:upmatev2/widgets/postSection/post_description.dart';
import 'package:upmatev2/widgets/postSection/post_image.dart';
import '../widgets/global/blur_loading.dart';
import '../widgets/postDetail/app_bar.dart';
import '../widgets/postDetail/comment.dart';
import '../widgets/postDetail/header.dart';
import '../widgets/postDetail/type_comment_section.dart';

class PostDetailView extends StatelessWidget {
  const PostDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PostDetailController>();
    final post = controller.post;
    return Scaffold(
      body: GetBuilder<PostDetailController>(
        builder: (_) => WillPopScope(
          onWillPop: () {
            if (controller.isShowEmoji.value) {
              controller.isShowEmoji.value = false;
            } else {
              Get.back();
            }
            controller.update();
            return Future.value(false);
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    PostDetailHeader(post: post),
                    const SizedBox(height: 10),
                    PostImage(post: post),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PostAction(post: post),
                          const SizedBox(height: 15),
                          PostDescription(post: post),
                          const SizedBox(height: 5),
                          PostDetailCommentSection(post: post)
                        ],
                      ),
                    ),
                    const SizedBox(height: 160)
                  ],
                ),
              ),
              const PostDetailAppBar(),
              PostDetailTypeComment(post: post),
              Obx(() => controller.isDeleting.value
                  ? const BlurLoading()
                  : const SizedBox())
            ],
          ),
        ),
      ),
    );
  }
}
