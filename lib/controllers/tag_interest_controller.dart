import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'verify_controller.dart';

class TagInterestController extends GetxController {
  late final VerifyController _verifyController;
  late final bool isLogin;
  late TextEditingController edtTagInterest;
  List<String> selectedTags = [];
  RxBool isLoading = false.obs;
  RxBool isEmptyText = true.obs;
  Map<String, String> tags = {
    "math".tr: "math",
    "calculus".tr: "calculus",
    "algebra".tr: "algebra",
    "economy".tr: "economy",
    "statistics".tr: "statistics",
    "digital_system".tr: "digital_system",
    "linear_algebra".tr: "linear_algebra",
    "physics".tr: "physics",
    "robotic".tr: "robotic",
    "programming".tr: "programming",
    "accountant".tr: "accountant"
  };

  @override
  void onInit() {
    _verifyController = Get.find<VerifyController>();
    edtTagInterest = TextEditingController();
    isLogin = _verifyController.isLogin;
    super.onInit();
  }

  @override
  void onClose() {
    edtTagInterest.dispose();
    super.onClose();
  }

  void toggleInterest(int index) {
    if (selectedTags.contains(tags.values.elementAt(index))) {
      selectedTags.remove(tags.values.elementAt(index));
    } else {
      selectedTags.add(tags.values.elementAt(index));
    }
    update();
  }
}
