import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:upmatev2/repositories/post_repository.dart';
import '../models/post_model.dart';

class HomeController extends GetxController {
  List<PostModel>? posts;
  RxInt selectedIndex = 0.obs;
  RxInt selectedImage = 0.obs;
  RxBool isFullText = false.obs;
  RxBool isLoading = false.obs;

  @override
  Future<void> onInit() async {
    isLoading.value = true;
    posts = await PostRepository().getPosts();
    posts!.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
    isLoading.value = false;
    for (var i = 0; i < posts!.length; i++) {
      debugPrint("tes: ${posts![i].user!.username}");
      debugPrint("userPhoto: ${posts![i].userPhoto}");
    }
    super.onInit();
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
    posts = await PostRepository().getPosts();
    isLoading.value = false;
    update();
  }
}
