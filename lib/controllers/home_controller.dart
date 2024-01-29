import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/models/comment_model.dart';
import 'package:upmatev2/repositories/post_repository.dart';
import '../models/post_model.dart';
import '../widgets/global/snack_bar.dart';

class HomeController extends GetxController {
  late final StartController _startController;
  late final ScrollController scrollController;
  late final PostRepository postRepository;
  late final String _thisUser;
  List<PostModel>? posts;
  late PostModel lastPost;
  RxInt selectedIndex = 0.obs;
  RxInt oldSelectedImage = 0.obs;
  RxInt selectedPostIndex = 0.obs;
  RxBool isFullText = false.obs;
  RxBool isLoading = false.obs;
  RxBool isDeleting = false.obs;
  RxBool isLoadMore = false.obs;

  @override
  Future<void> onInit() async {
    _startController = Get.find<StartController>();
    scrollController = ScrollController();
    postRepository = PostRepository();
    await _getPosts();
    if (!(isLoading.value && isLoadMore.value)) await _getMorePosts();
    _thisUser = _startController.user!.uid;
    super.onInit();
  }

  Future<void> _getPosts() async {
    isLoading.value = true;
    posts = await postRepository.getPosts();
    isLoading.value = false;
    update();
  }

  Future<void> _getMorePosts() async {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadMore.value) {
        isLoadMore.value = true;
        final additionalPost = await postRepository.getMorePosts();
        posts!.addAll(additionalPost);
        isLoadMore.value = false;
        update();
      }
    });
  }

  Future<void> toggleLike(PostModel post) async {
    if (post.likes.contains(_thisUser)) {
      post.likes.remove(_thisUser);
    } else {
      post.likes.add(_thisUser);
    }
    await post.toggleLike();
  }

  Future<void> toggleBookmark(PostModel post) async {
    if (post.bookmarks.contains(_thisUser)) {
      post.bookmarks.remove(_thisUser);
    } else {
      post.bookmarks.add(_thisUser);
    }
    await post.toggleBookmark();
  }

  Future<void> deletePost(PostModel post, int index) async {
    isDeleting.value = true;
    try {
      await postRepository.deletePost(post.ref.path);
      if (post.ref.id.contains(posts![index].ref.id)) {
        posts!.removeAt(index);
      }
      await _startController.refreshStart();
      SnackBarWidget.showSnackBar(true, "successfully_deleted_the_post".tr);
    } catch (e) {
      SnackBarWidget.showSnackBar(false, "failed_to_delete_post".tr);
      debugPrint(e.toString());
    }
    isDeleting.value = false;
    update();
  }

  String handleText(PostModel post) {
    final String desc = post.postDescription;
    if (post.isFullDesc) {
      return desc;
    } else {
      if (desc.length > 80) {
        return "${desc.substring(0, 80)}...";
      }
    }
    return desc;
  }

  String postingTimePassed(PostModel post) {
    DateTime now = DateTime.timestamp();
    DateTime postTime = post.timestamp!;
    Duration difference = now.difference(postTime);
    String ago = "ago".tr;
    String second = difference.inSeconds == 1 ? "second".tr : "seconds".tr;
    String minute = difference.inMinutes == 1 ? "minute".tr : "minutes".tr;
    String hour = difference.inHours == 1 ? "hour".tr : "hours".tr;
    String day = difference.inDays == 1 ? "day".tr : "days".tr;

    if (difference.inSeconds < 60) {
      return "${difference.inSeconds} $second $ago";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} $minute $ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} $hour $ago";
    } else {
      return "${difference.inDays} $day $ago";
    }
  }

  Future<void> refreshPosts() async {
    isLoading.value = true;
    await _getPosts();
    isLoading.value = false;
    update();
  }

  String commentTimePassed(CommentModel comment) {
    DateTime now = DateTime.timestamp();
    DateTime postTime = comment.date;
    Duration difference = now.difference(postTime);
    String ago = "ago".tr;
    String second = difference.inSeconds == 1 ? "second".tr : "seconds".tr;
    String minute = difference.inMinutes == 1 ? "minute".tr : "minutes".tr;
    String hour = difference.inHours == 1 ? "hour".tr : "hours".tr;
    String day = difference.inDays == 1 ? "day".tr : "days".tr;

    if (difference.inSeconds < 60) {
      return "${difference.inSeconds} $second $ago";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} $minute $ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} $hour $ago";
    } else {
      return "${difference.inDays} $day $ago";
    }
  }
}
