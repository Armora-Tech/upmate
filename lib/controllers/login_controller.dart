import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late TextEditingController email;
  late TextEditingController pass;
  RxBool isVisible = true.obs;

  @override
  void onInit() {
    email = TextEditingController();
    pass = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    pass.dispose();
    super.onClose();
  }

  void changeVisibility() {
    isVisible.toggle();
  }
}
