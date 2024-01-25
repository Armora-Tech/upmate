import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/post_detail_controller.dart';

import '../../controllers/home_controller.dart';
import '../../controllers/observer/action_post_controller.dart';
import '../../controllers/start_controller.dart';
import '../../models/post_model.dart';
import '../../routes/route_name.dart';
import '../../themes/app_font.dart';

class PostAction extends StatelessWidget {
  final PostModel post;
  const PostAction({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final startController = Get.find<StartController>();
    final actionPostController = Get.find<ActionPostController>();
    late final PostDetailController postDetailController;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () async {
            await controller.toggleLike(post);
            actionPostController.update();
          },
          child: Container(
            color: Colors.white,
            child: GetBuilder<ActionPostController>(
              builder: (_) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    !controller.isLoading.value &&
                            post.likes.contains(startController.user!.uid)
                        ? "assets/svg/favorite.svg"
                        : "assets/svg/favorite_outlined.svg",
                    semanticsLabel: 'favorite',
                    height: 27,
                    width: 27,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "${controller.isLoading.value ? 0 : post.likes.length}",
                    style: AppFont.text10,
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: controller.isLoading.value
              ? () {}
              : () {
                  if (Get.currentRoute == RouteName.postDetail) {
                    postDetailController = Get.find<PostDetailController>();
                    postDetailController.focusNode.requestFocus();
                  } else {
                    controller.oldSelectedImage.value =
                        post.selectedDotsIndicator;
                    Get.toNamed(RouteName.postDetail, arguments: post);
                  }
                  controller.update();
                },
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/svg/comment.svg",
                    height: 27, width: 27, semanticsLabel: 'comment'),
                const SizedBox(height: 2),
                Text(
                  "${controller.isLoading.value ? 0 : post.comments?.length}",
                  style: AppFont.text10,
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            await controller.toggleBookmark(post);
            actionPostController.update();
          },
          child: Container(
            color: Colors.white,
            child: GetBuilder<ActionPostController>(
              builder: (_) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                      !controller.isLoading.value &&
                              post.bookmarks.contains(startController.user!.uid)
                          ? "assets/svg/bookmark.svg"
                          : "assets/svg/bookmark_outlined.svg",
                      height: 27,
                      width: 27,
                      semanticsLabel: 'bookmark'),
                  const SizedBox(height: 2),
                  Text(
                    "${controller.isLoading.value ? 0 : post.bookmarks.length}",
                    style: AppFont.text10,
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {},
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/svg/share.svg",
                    height: 27, width: 27, semanticsLabel: 'share'),
                const SizedBox(height: 2),
                Text(
                  "${controller.isLoading.value ? 0 : 0}",
                  style: AppFont.text10,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
