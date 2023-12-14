import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/input_validator.dart';

class EditProfileController extends GetxController {
  late final TextEditingController textEditingController;
  late final TextEditingController confirmPass;
  RxString? errorMessage;
  RxString? errorConfPassMessage;
  RxBool isEmptyText = true.obs;
  RxBool isLoading = false.obs;
  File? image;

  Map<String, dynamic> data = {
    "Nama Pengguna": "Flora Shafiqa",
    "Nama Lengkap": "Flora Shafiqa Riyadi",
    "Bio": "",
    "Email": "flora@gmail.com",
    "Password": "*****"
  };

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
    textEditingController = TextEditingController();
    confirmPass = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    confirmPass.dispose();
    super.onClose();
  }

  Future<void> save(String input, int? minLength, int? maxLength) async {
    inputValidation(input, minLength);
    debugPrint("hah: $minLength dan $maxLength");
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 2000));
    if (input.toLowerCase() != "password" &&
        isInputValid(minLength, maxLength).value) {
      errorMessage = null;
      errorConfPassMessage = null;
      textEditingController.clear();
      confirmPass.clear();
      Get.back();
      Get.snackbar("Memperbarui $input", "Berhasil",
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10));
    } else {
      if (isPassValid().value) {
        errorMessage = null;
        errorConfPassMessage = null;
        textEditingController.clear();
        confirmPass.clear();
        Get.back();
        Get.snackbar("Memperbarui $input", "Berhasil",
            colorText: Colors.black,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10));
      }
    }
    isLoading.value = false;
    update();
  }

  RxBool isInputValid(int? minLength, int? maxLength) =>
      InputValidator.isValid(textEditingController, minLength, maxLength).obs;

  RxBool isPassValid() {
    return (InputValidator.isPassValid(textEditingController) &&
            InputValidator.isPassValid(confirmPass) &&
            textEditingController.text == confirmPass.text)
        .obs;
  }

  void inputValidation(String input, int? minLength) {
    errorMessage = InputValidator.validationMessage(
        input, textEditingController, minLength);
    errorConfPassMessage =
        InputValidator.confPassValidationMessage(confirmPass);
    if ((textEditingController.text != confirmPass.text) &&
        (InputValidator.isPassValid(
              textEditingController,
            ) &&
            InputValidator.isPassValid(confirmPass))) {
      errorMessage = InputValidator.passValidationMessage(
        textEditingController,
      );
      errorConfPassMessage = "Password dan konfirmasi password harus sama".obs;
    } else {
      errorMessage = InputValidator.passValidationMessage(
        textEditingController,
      );
      errorConfPassMessage =
          InputValidator.confPassValidationMessage(confirmPass);
    }
  }

  RxBool isPass(int index) =>
      (data.keys.elementAt(index).toLowerCase() == "password").obs;
  RxBool isEmail(int index) =>
      (data.keys.elementAt(index).toLowerCase() == "email").obs;
}
