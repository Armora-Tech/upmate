import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/utils/input_validator.dart';

import '../routes/route_name.dart';

class SignupController extends GetxController {
  late TextEditingController username;
  late TextEditingController fullName;
  late TextEditingController email;
  late TextEditingController pass;
  late TextEditingController confPass;
  late FocusNode focusNode;
  late FocusNode confirmPassfocusNode;
  RxString? errorPassMessage;
  RxString? errorConfPassMessage;
  RxString? errorEmailMessage;
  RxString? errorUsernameMessage;
  RxString? errorFullNameMessage;
  RxBool isVisible = true.obs;
  RxBool isConfirmPassVisible = true.obs;
  RxBool isFocused = false.obs;
  RxBool isConfirmPassFocused = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    username = TextEditingController();
    fullName = TextEditingController();
    email = TextEditingController();
    pass = TextEditingController();
    confPass = TextEditingController();
    focusNode = FocusNode();
    confirmPassfocusNode = FocusNode();
    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
      update();
    });
    confirmPassfocusNode.addListener(() {
      isConfirmPassFocused.value = confirmPassfocusNode.hasFocus;
      update();
    });
    super.onInit();
  }

  @override
  void onClose() {
    username.dispose();
    fullName.dispose();
    email.dispose();
    pass.dispose();
    confPass.dispose();
    focusNode.dispose();
    super.onClose();
  }

  Future<void> signup() async {
    inputValidation();
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    if (isInputValid().value) {
      Get.toNamed(RouteName.verify);
    }
    isLoading.value = false;
    update();
  }

  RxBool isInputValid() {
    return (InputValidator.isFullNameValid(fullName) &&
            InputValidator.isUsernameValid(username) &&
            email.text.isEmail &&
            InputValidator.isPassValid(pass) &&
            InputValidator.isPassValid(confPass) &&
            (pass.text == confPass.text))
        .obs;
  }

  void inputValidation() {
    errorFullNameMessage = InputValidator.fullNameValidationMessage(fullName);
    errorUsernameMessage = InputValidator.usernameValidationMessage(username);
    errorEmailMessage = InputValidator.emailValidationMessage(email);
    errorPassMessage = InputValidator.passValidationMessage(pass);
    if ((pass.text != confPass.text) &&
        (InputValidator.isPassValid(pass) &&
            InputValidator.isPassValid(confPass))) {
      errorConfPassMessage = "Password dan konfirmasi password harus sama".obs;
    } else {
      errorConfPassMessage = InputValidator.confPassValidationMessage(confPass);
    }
  }
}
