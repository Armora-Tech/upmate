import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/utils/input_validator.dart';
import '../routes/route_name.dart';
import '../repositories/auth.dart';

class SignupController extends GetxController {
  final _auth = Auth();
  late TextEditingController username;
  late TextEditingController fullName;
  late TextEditingController email;
  late TextEditingController pass;
  late TextEditingController confPass;
  late TextEditingController edtTagInterest;
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
  RxBool isEmptyText = true.obs;

  List<String> selectedTags = [];
  Map<String, String> tags = {
    "math".tr: "math",
    "calculus".tr: "calculus",
    "algebra".tr: "algebra",
    "economy".tr: "economy",
    "statistics".tr: "statistics",
    "digital_system".tr: "digital_system",
    "linear_algebra".tr: "linear_algebra",
    "physics".tr: "physics",
    "robotic".tr: "robotic",
    "programming".tr: "programming",
    "accountant".tr: "accountant"
  };

  @override
  void onInit() {
    username = TextEditingController();
    fullName = TextEditingController();
    email = TextEditingController();
    pass = TextEditingController();
    confPass = TextEditingController();
    focusNode = FocusNode();
    confirmPassfocusNode = FocusNode();
    edtTagInterest = TextEditingController();
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
    edtTagInterest.dispose();
    super.onClose();
  }

  Future<void> signup() async {
    inputValidation();
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    if (isInputValid().value) {
      await _auth.sendOTP(email.text);
      Get.toNamed(RouteName.verify);
    }
    isLoading.value = false;
    update();
  }

  RxBool isInputValid() {
    return (InputValidator.isFullNameValid(fullName) &&
            InputValidator.isUsernameLengthValid(username) &&
            InputValidator.isUsernameFormatValid(username) &&
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
    errorConfPassMessage =
        InputValidator.confPassValidationMessage(confPass, pass);
  }

  void toggleInterest(int index) {
    if (selectedTags.contains(tags.values.elementAt(index))) {
      selectedTags.remove(tags.values.elementAt(index));
    } else {
      selectedTags.add(tags.values.elementAt(index));
    }
    update();
  }
}
