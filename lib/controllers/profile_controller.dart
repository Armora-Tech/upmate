import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/home_controller.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/models/post_model.dart';
import 'package:upmatev2/widgets/profile/my_bookmark.dart';
import 'package:upmatev2/widgets/profile/my_post.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;
  final homeController = Get.find<HomeController>();
  final startController = Get.find<StartController>();
  RxInt selectedTab = 0.obs;
  List<PostModel> myPosts = [];

  List pages = [const MyPost(), const MyBookmark()];

  @override
  void onInit() {
    tabController = TabController(length: pages.length, vsync: this);
    homeController.posts?.forEach((element) {
      if (element.user!.uid == startController.user!.uid) {
        myPosts.add(element);
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void refreshMyPosts() {
    myPosts.clear();
    homeController.posts?.forEach((element) {
      if (element.user!.uid == startController.user!.uid) {
        myPosts.add(element);
      }
    });
  }

  void selectTab(int index) {
    selectedTab.value = index;
    tabController.animateTo(selectedTab.value,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    update();
  }
}
