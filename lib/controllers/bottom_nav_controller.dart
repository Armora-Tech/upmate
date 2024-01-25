import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/pages/createPost/create_post_page.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/pages/chat.dart';
import 'package:upmatev2/pages/home.dart';
import 'package:upmatev2/pages/notification_page.dart';

import '../pages/explore.dart';

class BottomNavController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt selectedTab = 0.obs;
  RxInt oldSelectedTab = 0.obs;
  RxDouble initialIconSize = 26.0.obs;
  RxDouble initialTextSize = 9.0.obs;
  RxDouble iconSize = 26.0.obs;
  RxDouble textSize = 9.0.obs;
  RxDouble widthTab = (Get.width / 5).obs;
  late final TabController tabController;

  final List<Widget> pages = [
    const HomeView(),
    const ExploreView(),
    const CreatePostView(),
    const NotificationView(),
    const ChatView()
  ];

  @override
  void onInit() {
    tabController = TabController(length: pages.length, vsync: this);
    debugPrint("init");
    super.onInit();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void selectTab(int index) {
    oldSelectedTab.value = selectedTab.value;
    if (index == 2) {
      selectedTab.value = oldSelectedTab.value;
      Get.toNamed(RouteName.post);
    } else {
      selectedTab.value = index;
      tabController.animateTo(selectedTab.value,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  double handleBarAnimation() {
    switch (selectedTab.value) {
      case 0:
        return 0;
      case 1:
        return widthTab.value;
      case 3:
        return widthTab.value * 3;
      case 4:
        return widthTab.value * 4;
      default:
        return widthTab.value * oldSelectedTab.value;
    }
  }
}
