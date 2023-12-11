import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/route_name.dart';

class SignupController extends GetxController {
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController pass;
  late TextEditingController confPass;
  late FocusNode focusNode;
  late FocusNode confirmPassfocusNode;
  RxBool isVisible = true.obs;
  RxBool isConfirmPassVisible = true.obs;
  RxBool isFocused = false.obs;
  RxBool isConfirmPassFocused = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    username = TextEditingController();
    email = TextEditingController();
    pass = TextEditingController();
    confPass = TextEditingController();
    focusNode = FocusNode();
    confirmPassfocusNode = FocusNode();
    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });
    confirmPassfocusNode.addListener(() {
      isConfirmPassFocused.value = confirmPassfocusNode.hasFocus;
    });
    super.onInit();
  }

  @override
  void onClose() {
    username.dispose();
    email.dispose();
    pass.dispose();
    confPass.dispose();
    focusNode.dispose();
    super.onClose();
  }

  Future<void> signup() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    Get.toNamed(RouteName.verify);
    isLoading.value = false;
  }

  void changeVisibility() {
    isVisible.toggle();
  }

  void changeConfirmPassVisibility() {
    isConfirmPassVisible.toggle();
  }
}
