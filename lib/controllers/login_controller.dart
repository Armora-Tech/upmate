import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/route_name.dart';
import '../utils/input_validator.dart';

class LoginController extends GetxController {
  late TextEditingController email;
  late TextEditingController pass;
  late FocusNode focusNode;
  RxString? errorEmailMessage;
  RxString? errorPassMessage;
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
      update();
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
    inputValidation();
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    if (isInputValid().value) {
      Get.toNamed(RouteName.start);
    }
    isLoading.value = false;
    update();
  }

  void inputValidation() {
    errorEmailMessage = InputValidator.emailValidationMessage(email);
    errorPassMessage = InputValidator.passValidationMessage(pass);
  }

  RxBool isInputValid() =>
      (email.text.isEmail && InputValidator.isPassValid(pass)).obs;
}
