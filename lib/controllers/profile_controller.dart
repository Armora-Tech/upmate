import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/widgets/profile/my_bookmark.dart';
import 'package:upmatev2/widgets/profile/my_post.dart';

import 'start_controller.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;
  late final StartController _startController;
  RxInt selectedTab = 0.obs;
  RxInt highlightDescLength = 80.obs;
  RxBool isFullText = false.obs;
  RxBool isLoading = false.obs;
  List pages = [const MyPost(), const MyBookmark()];
  String text = "";

  @override
  Future<void> onInit() async {
    _startController = Get.find<StartController>();
    if (_startController.isShowingBookmarks.value) {
      selectedTab.value = 1;
    } else {
      selectedTab.value = 0;
    }
    tabController = TabController(
        length: pages.length, vsync: this, initialIndex: selectedTab.value);
    _startController.isShowingBookmarks.value = false;
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
      if (text.length > highlightDescLength.value) {
        return "${text.substring(0, highlightDescLength.value)}...";
      }
    }
    return text;
  }
}
