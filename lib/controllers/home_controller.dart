import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/repositories/post_repository.dart';
import '../models/post_model.dart';
import '../widgets/global/snack_bar.dart';

class HomeController extends GetxController {
  List<PostModel>? posts;
  RxInt selectedIndex = 0.obs;
  RxInt selectedImage = 0.obs;
  RxBool isFullText = false.obs;
  RxBool isLoading = false.obs;
  RxBool isDeleting = false.obs;

  @override
  Future<void> onInit() async {
    isLoading.value = true;
    await _getPosts();
    isLoading.value = false;
    super.onInit();
    update();
  }

  Future<void> _getPosts() async {
    posts = await PostRepository().getPosts();
    posts!.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
  }

  Future<void> deletePost(PostModel post, int index) async {
    isDeleting.value = true;
    debugPrint(" post id : ${post.ref.id}");
    try {
      await PostRepository().deletePost(post.ref.path);

      if (post.ref.id.contains(posts![index].ref.id)) {
        posts!.removeAt(index);
      }
      SnackBarWidget.showSnackBar(true, "successfully_deleted_the_post".tr);
    } catch (e) {
      SnackBarWidget.showSnackBar(false, "failed_to_delete_post".tr);
      debugPrint(e.toString());
    }
    isDeleting.value = false;
    update();
  }

  String handleText(String text) {
    if (isFullText.value) {
      return text;
    } else {
      if (text.length > 80) {
        return "${text.substring(0, 80)}...";
      }
    }
    return text;
  }

  String postingTimePassed(int index) {
    DateTime now = DateTime.timestamp();
    DateTime postTime = posts![index].timestamp!;
    Duration difference = now.difference(postTime);
    String ago = "ago".tr;

    if (difference.inSeconds < 60) {
      return "${difference.inSeconds} ${"seconds".tr} $ago";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} ${"minutes".tr} $ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} ${"hours".tr} $ago";
    } else {
      return "${difference.inDays} ${"days".tr} $ago";
    }
  }

  Future<void> refreshPosts() async {
    isLoading.value = true;
    _getPosts();
    isLoading.value = false;
    update();
  }
}
