import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostDetailController extends GetxController {
  late TextEditingController textEditingController;
  RxInt selectedIndex = 0.obs;
  RxBool isTextFieldEmpty = true.obs;
  RxString fullText =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
          .obs;

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
  void onInit() {
    textEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}
