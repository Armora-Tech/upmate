import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/widgets/profile/my_bookmark.dart';
import 'package:upmatev2/widgets/profile/my_post.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;
  RxInt selectedTab = 0.obs;
  RxBool isFullText = false.obs;
  RxBool isLoading = false.obs;
  List pages = [const MyPost(), const MyBookmark()];
  String text = "";

  @override
  Future<void> onInit() async {
    tabController = TabController(length: pages.length, vsync: this);
    super.onInit();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void selectTab(int index) {
    selectedTab.value = index;
    tabController.animateTo(selectedTab.value,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
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
}
