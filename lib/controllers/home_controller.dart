import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/repositories/post_repository.dart';
import '../models/post_model.dart';

class HomeController extends GetxController {
  List<PostModel>? posts;
  RxInt selectedIndex = 0.obs;
  RxBool isFullText = false.obs;
  RxBool isLoading = false.obs;

  @override
  Future<void> onInit() async {
    isLoading.value = true;
    posts = await PostRepository().getPosts();
    isLoading.value = false;
    debugPrint("HOMEPOSE: $posts");
    super.onInit();
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

  String usernameWithAt(int index) {
    return posts![index].user!.username == ""
        ? "@${posts![index].user!.displayName.replaceAll(" ", "").toLowerCase()}"
        : "@${posts![index].user!.username.toLowerCase()}";
  }
}
