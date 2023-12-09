import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/route_name.dart';

class LoginController extends GetxController {
  late TextEditingController email;
  late TextEditingController pass;
  late FocusNode focusNode;
  RxBool isVisible = true.obs;
  RxBool isFocused = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    email = TextEditingController();
    pass = TextEditingController();
    focusNode = FocusNode();
    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    pass.dispose();
    focusNode.dispose();
    super.onClose();
  }

  Future<void> login() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    Get.toNamed(RouteName.start);
    isLoading.value = false;
  }

  void changeVisibility() {
    isVisible.toggle();
  }
}
