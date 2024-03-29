import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/widgets/global/snack_bar.dart';
import '../repositories/user_repository.dart';
import '../utils/input_validator.dart';

class EditProfileController extends GetxController {
  late final StartController _startController;
  late TextEditingController username;
  late TextEditingController fullName;
  late TextEditingController email;
  late TextEditingController pass;
  late TextEditingController confPass;
  late TextEditingController bio;
  late TextEditingController inputText;
  RxBool isEmptyText = true.obs;
  RxBool isLoading = false.obs;
  RxBool isFullNameInvalid = false.obs;
  RxBool isUsernameInvalid = false.obs;
  RxBool isEmailInvalid = false.obs;
  RxBool isPassInvalid = false.obs;
  RxBool isConfPassInvalid = false.obs;
  RxBool isEditBanner = false.obs;
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
    _startController = Get.find<StartController>();
    data = {
      "username".tr: _startController.user!.username == ""
          ? _startController.user!.displayName
          : _startController.user!.username,
      "full_name".tr: _startController.user!.displayName,
      "Bio": _startController.user!.bio ?? "",
      "Email": _startController.user!.email,
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
    isLoading.value = true;
    if (input.toLowerCase() == "bio") {
      await UserRepository().updateBio(bio.text);
    } else {
      await Future.delayed(const Duration(milliseconds: 2000));
    }
    await _startController.refreshStart();
    inputText.clear();
    Get.back();
    if (Get.locale!.languageCode == "id") {
      SnackBarWidget.showSnackBar(
          true, "Berhasil memperbarui ${input.toLowerCase()}");
    } else {
      SnackBarWidget.showSnackBar(
          true, "Successfully update ${input.toLowerCase()}");
    }
    isLoading.value = false;
    Get.forceAppUpdate();
  }

  String? inputValidation(String? value, String input) {
    final controller = Get.find<EditProfileController>();
    if (input == "username".tr) {
      return InputValidator.usernameMessageValidation(value, controller);
    } else if (input == "full_name".tr) {
      return InputValidator.fullNameMessageValidation(value, controller);
    } else if (input == "Email") {
      return InputValidator.emailMessageValidation(value, controller);
    } else if (input == "password".tr) {
      return InputValidator.passMessageValidation(value, controller);
    }
    return null;
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
