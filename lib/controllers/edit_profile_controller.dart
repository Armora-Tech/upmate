import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/widgets/global/snack_bar.dart';

import '../utils/input_validator.dart';

class EditProfileController extends GetxController {
  late TextEditingController username;
  late TextEditingController fullName;
  late TextEditingController email;
  late TextEditingController pass;
  late TextEditingController confPass;
  late TextEditingController bio;
  late TextEditingController inputText;
  RxString? errorMessage;
  RxString? errorPassMessage;
  RxString? errorConfPassMessage;
  RxString? errorEmailMessage;
  RxString? errorUsernameMessage;
  RxString? errorFullNameMessage;
  final startController = Get.find<StartController>();
  RxBool isEmptyText = true.obs;
  RxBool isLoading = false.obs;
  File? image;
  Map<String, dynamic>? data;

  List<int?> maxLength = [
    InputValidator.maxUsernameLength,
    InputValidator.maxFullNameLength,
    InputValidator.maxBioLength,
    null,
    InputValidator.maxPassLength
  ];
  List<int?> minLength = [
    InputValidator.minUsernameLength,
    InputValidator.minFullNameLength,
    InputValidator.minBioLength,
    null,
    InputValidator.minPassLength
  ];

  @override
  void onInit() {
    username = TextEditingController();
    fullName = TextEditingController();
    email = TextEditingController();
    pass = TextEditingController();
    confPass = TextEditingController();
    bio = TextEditingController();
    inputText = TextEditingController();
    data = {
      "username".tr: startController.user!.username == ""
          ? startController.displayName!
          : startController.user!.username,
      "full_name".tr: startController.displayName,
      "Bio": "",
      "Email": startController.email,
      "password".tr: "*****"
    };
    super.onInit();
  }

  @override
  void onClose() {
    username.dispose();
    fullName.dispose();
    email.dispose();
    pass.dispose();
    bio.dispose();
    confPass.dispose();
    super.onClose();
  }

  Future<void> save(String input) async {
    inputValidation(input);
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 2000));
    if (isValid(input).value) {
      inputText.clear();
      Get.back();
      if (Get.locale!.languageCode == "id") {
        SnackBarWidget.showSnackBar(
            "Memperbarui $input", "Berhasil", Colors.black);
      } else {
        SnackBarWidget.showSnackBar("Update $input", "Success", Colors.black);
      }
    }
    isLoading.value = false;
    update();
  }

  RxBool isValid(String input) {
    if (input == "username".tr) {
      return (InputValidator.isUsernameLengthValid(username) &&
              InputValidator.isUsernameFormatValid(username))
          .obs;
    } else if (input == "full_name".tr) {
      return (InputValidator.isFullNameValid(fullName)).obs;
    } else if (input == "Email") {
      return (email.text.isEmail).obs;
    } else if (input == "Bio") {
      return true.obs;
    } else if (input == "password".tr) {
      return ((InputValidator.isPassValid(pass)) &&
              (InputValidator.isPassValid(confPass)) &&
              pass.text == confPass.text)
          .obs;
    }
    return false.obs;
  }

  void inputValidation(String input) {
    if (input == "username".tr) {
      errorUsernameMessage = InputValidator.usernameValidationMessage(username);
      errorMessage = errorUsernameMessage;
    } else if (input == "full_name".tr) {
      errorFullNameMessage = InputValidator.fullNameValidationMessage(fullName);
      errorMessage = errorFullNameMessage;
    } else if (input == "Email") {
      errorEmailMessage = InputValidator.emailValidationMessage(email);
      errorMessage = errorEmailMessage;
    } else if (input == "password".tr) {
      errorPassMessage = InputValidator.passValidationMessage(pass);
      errorConfPassMessage =
          InputValidator.confPassValidationMessage(confPass, pass);
      errorMessage = errorPassMessage;
    }
  }

  void chooseInput(String input) {
    if (input == "username".tr) {
      inputText = username;
    } else if (input == "full_name".tr) {
      inputText = fullName;
    } else if (input == "Email") {
      inputText = email;
    } else if (input == "Bio") {
      inputText = bio;
    } else if (input == "password".tr) {
      inputText = pass;
    }
  }

  RxBool isPass(int index) =>
      (data!.keys.elementAt(index) == "password".tr).obs;
  RxBool isEmail(int index) => (data!.keys.elementAt(index) == "Email").obs;
}
