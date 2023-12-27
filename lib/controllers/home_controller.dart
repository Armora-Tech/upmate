import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/repositories/post_repository.dart';
import '../models/post_model.dart';

class HomeController extends GetxController {
  List<PostModel>? posts;
  RxInt selectedIndex = 0.obs;
  RxString fullText =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
          .obs;
  RxBool isFullText = false.obs;
  RxBool isLoading = false.obs;

  final Map<String, dynamic> action = {
    "90": Icons.share_outlined,
    "120": Icons.bookmark_outline_rounded,
    "6": Icons.chat_bubble_outline_rounded,
    "1.3k": Icons.favorite_border_rounded
  };

  final List<String> images = [
    "assets/images/naruto.jpg",
    "assets/images/quran.png",
    "assets/images/gojek.png",
    "assets/images/movie-app.png",
    "assets/images/jkt-app.png",
  ];

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
