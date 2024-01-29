import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/post_detail_controller.dart';
import 'package:upmatev2/models/comment_model.dart';
import 'package:upmatev2/widgets/postSection/bookmarks_button.dart';
import 'package:upmatev2/widgets/postSection/comment_button.dart';
import 'package:upmatev2/widgets/postSection/likes_button.dart';

import '../../controllers/home_controller.dart';
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
    late final PostDetailController postDetailController;
    int i = 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () async {
            await controller.toggleLike(post);
            if (Get.previousRoute != RouteName.profile) {
              await startController.refreshMyPosts();
            }
          },
          child: Container(
            color: Colors.white,
            child: StreamBuilder<List<dynamic>>(
              stream: controller.postRepository.getLikesStream(post.ref),
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.hasError) {
                  return LikesButton(likes: post.likes);
                }
                if (!snapshot.hasData) {
                  return LikesButton(likes: post.likes);
                }
                final likes = snapshot.data;
                post.likes = likes!;
                return LikesButton(likes: likes);
              },
            ),
          ),
        ),
        GestureDetector(
          onTap: controller.isLoading.value
              ? () {}
              : () {
                  if (Get.currentRoute == RouteName.postDetail) {
                    if (i == 0) {
                      postDetailController = Get.find<PostDetailController>();
                    }
                    i++;
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
            child: StreamBuilder<List<CommentModel>?>(
              stream: controller.postRepository.getCommentsStream(post.ref),
              builder: (BuildContext context,
                  AsyncSnapshot<List<CommentModel>?> snapshot) {
                if (snapshot.hasError) {
                  return CommentButton(comments: post.comments!);
                }
                if (!snapshot.hasData) {
                  return CommentButton(comments: post.comments!);
                }
                final comments = snapshot.data;
                return CommentButton(comments: comments!);
              },
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            await controller.toggleBookmark(post);
            await startController.refreshMyBookmarks();
            startController.update();
          },
          child: Container(
            color: Colors.white,
            child: StreamBuilder<List<dynamic>>(
              stream: controller.postRepository.getBookmarksStream(post.ref),
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.hasError) {
                  return BookmarksButton(bookmarks: post.bookmarks);
                }
                if (!snapshot.hasData) {
                  return BookmarksButton(bookmarks: post.bookmarks);
                }
                final bookmarks = snapshot.data;
                post.bookmarks = bookmarks!;
                return BookmarksButton(bookmarks: bookmarks);
              },
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
