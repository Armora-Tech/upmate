import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/views/chat.dart';
import 'package:upmatev2/views/home.dart';
import 'package:upmatev2/views/notification.dart';
import 'package:upmatev2/views/post.dart';
import 'package:upmatev2/views/explore.dart';

class BottomNavController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt selectedTab = 0.obs;
  RxInt oldSelectedTab = 0.obs;
  RxDouble initialIconSize = 26.0.obs;
  RxDouble initialTextSize = 9.0.obs;
  RxDouble iconSize = 26.0.obs;
  RxDouble textSize = 9.0.obs;
  double widthTab = Get.width / 5;
  late final TabController tabController;

  final Map<String, List<dynamic>> tabs = {
    "Home": [Icons.home_outlined, Icons.home_rounded],
    "Explore": [Icons.explore_outlined, Icons.explore_rounded],
    "Post": [Icons.add_box_outlined, Icons.add_box_rounded],
    "Notification": [Icons.notifications_outlined, Icons.notifications_rounded],
    "Chat": [Icons.chat_outlined, Icons.chat_rounded],
  };

  final List<Widget> pages = [
    const HomeView(),
    const ExploreView(),
    const PostView(),
    const NotificationView(),
    const ChatView()
  ];

  @override
  void onInit() {
    tabController = TabController(length: pages.length, vsync: this);
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
        return widthTab;
      case 3:
        return widthTab * 3;
      case 4:
        return widthTab * 4;
      default:
        return widthTab * oldSelectedTab.value;
    }
  }
}
