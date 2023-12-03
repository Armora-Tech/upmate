import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController pass;
  late TextEditingController confPass;
  RxBool isVisible = true.obs;
  RxBool isConfirmPassVisible = true.obs;

  @override
  void onInit() {
    username = TextEditingController();
    email = TextEditingController();
    pass = TextEditingController();
    confPass = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    username.dispose();
    email.dispose();
    pass.dispose();
    confPass.dispose();
    super.onClose();
  }

  void changeVisibility() {
    isVisible.toggle();
  }

  void changeConfirmPassVisibility() {
    isConfirmPassVisible.toggle();
  }
}
