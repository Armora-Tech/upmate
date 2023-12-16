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
      "Nama Pengguna": startController.user!.username == ""
          ? startController.displayName!
          : startController.user!.username,
      "Nama Lengkap": startController.displayName,
      "Bio": "",
      "Email": startController.email,
      "Password": "*****"
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
    chooseMessage(input);
    debugPrint("hah: $errorMessage");
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 2000));
    if (isValid(input).value) {
      inputText.clear();
      Get.back();
      SnackBarWidget.showSnackBar(
          "Memperbarui $input", "Berhasil", Colors.black);
    }
    isLoading.value = false;
    update();
  }

  RxBool isValid(String input) {
    switch (input) {
      case "Nama Pengguna":
        return (InputValidator.isUsernameLengthValid(username) &&
                InputValidator.isUsernameFormatValid(username))
            .obs;
      case "Nama Lengkap":
        return (InputValidator.isFullNameValid(fullName)).obs;
      case "Email":
        return (email.text.isEmail).obs;
      case "Bio":
        return true.obs;
      case "Password":
        return ((InputValidator.isPassValid(pass)) &&
                (InputValidator.isPassValid(confPass)) &&
                pass.text == confPass.text)
            .obs;
      default:
        return false.obs;
    }
  }

  void inputValidation(String input) {
    switch (input) {
      case "Nama Pengguna":
        errorUsernameMessage =
            InputValidator.usernameValidationMessage(username);
        break;
      case "Nama Lengkap":
        errorFullNameMessage =
            InputValidator.fullNameValidationMessage(fullName);
        break;
      case "Email":
        errorEmailMessage = InputValidator.emailValidationMessage(email);
        break;
      case "Password":
        errorPassMessage = InputValidator.passValidationMessage(pass);
        errorConfPassMessage =
            InputValidator.confPassValidationMessage(confPass, pass);
        break;
      default:
        break;
    }
  }

  void chooseMessage(String input) {
    switch (input) {
      case "Nama Pengguna":
        errorMessage = errorUsernameMessage;
        break;
      case "Nama Lengkap":
        errorMessage = errorFullNameMessage;
        break;
      case "Email":
        errorMessage = errorEmailMessage;
        break;
      case "Password":
        errorMessage = errorPassMessage;
        break;
      default:
        break;
    }
  }

  void chooseInput(String input) {
    switch (input) {
      case "Nama Pengguna":
        inputText = username;
        break;
      case "Nama Lengkap":
        inputText = fullName;
        break;
      case "Email":
        inputText = email;
        break;
      case "Bio":
        inputText = bio;
        break;
      case "Password":
        inputText = pass;
        break;
      default:
        break;
    }
  }

  RxBool isPass(int index) =>
      (data!.keys.elementAt(index).toLowerCase() == "password").obs;
  RxBool isEmail(int index) =>
      (data!.keys.elementAt(index).toLowerCase() == "email").obs;
}
