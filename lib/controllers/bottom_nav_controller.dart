import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/views/chat.dart';
import 'package:upmatev2/views/home.dart';
import 'package:upmatev2/views/notification.dart';
import 'package:upmatev2/views/post.dart';
import 'package:upmatev2/views/search.dart';

class BottomNavController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt selectedTab = 0.obs;
  late final TabController tabController;

  final Map<String, List<dynamic>> tabs = {
    "Home": [Icons.home_outlined, Icons.home_rounded],
    "Search": [Icons.search_outlined, Icons.search],
    "Post": [Icons.add_box_outlined, Icons.add_box],
    "Notification": [Icons.notifications_outlined, Icons.notifications_rounded],
    "Chat": [Icons.chat_outlined, Icons.chat],
  };

  final List<Widget> pages = [
    const HomeView(),
    const SearchView(),
    const PostView(),
    const NotificationView(),
    const ChatView()
  ];

  void selectTab(int index) {
    selectedTab.value = index;
    tabController.animateTo(selectedTab.value,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

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
}
