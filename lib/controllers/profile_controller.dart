import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/home_controller.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/widgets/profile/my_bookmark.dart';
import 'package:upmatev2/widgets/profile/my_post.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;
  RxBool isUser = true.obs;
  final homeController = Get.find<HomeController>();
  final startController = Get.find<StartController>();
  RxInt selectedTab = 0.obs;
  RxBool isFullText = false.obs;
  List pages = [const MyPost(), const MyBookmark()];
  String text =
      "Ada yang mau ikut aku???, ayo ikut ke dunia Flora simsalabim akan ku buat harimu menjadi penuh cinta. Hai Semuanya aku Flora fjshafjhdjhsdakjhfkdjshafkhkdashfkhjshafkhdkhsahdkhkshasjsdhfhjdhfjddjfhfjf";

  @override
  void onInit() {
    tabController = TabController(length: pages.length, vsync: this);
    final Map<String, dynamic> arguments = Get.arguments;
    isUser.value = arguments["isUser"];
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
