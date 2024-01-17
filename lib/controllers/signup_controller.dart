import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/widgets/global/snack_bar.dart';
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
  RxString inputOTP = "".obs;
  RxBool isVisible = true.obs;
  RxBool isConfirmPassVisible = true.obs;
  RxBool isFocused = false.obs;
  RxBool isConfirmPassFocused = false.obs;
  RxBool isLoading = false.obs;
  RxBool isEmptyText = true.obs;
  RxBool isFullNameInvalid = false.obs;
  RxBool isUsernameInvalid = false.obs;
  RxBool isEmailInvalid = false.obs;
  RxBool isPassInvalid = false.obs;
  RxBool isConfPassInvalid = false.obs;


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
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    await _auth.sendOTP(email.text);
    Get.toNamed(RouteName.verify);
    isLoading.value = false;
    update();
  }

  Future<void> verifyOTP() async {
    bool isVerified = await _auth.checkOTP(inputOTP.value);
    if (isVerified) {
      Get.toNamed(RouteName.tagInterest);
    } else {
      SnackBarWidget.showSnackBar(
          false, "${"verify_otp".tr} ${"otp_verification_failed".tr}");
    }
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
