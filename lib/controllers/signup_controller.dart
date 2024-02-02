import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/widgets/global/snack_bar.dart';
import '../models/user_model.dart';
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

  Future<void> signUp() async {
    isLoading.value = true;
    // DocumentReference userDocument = usersCollection.doc(uid);
    try {
      final userCredential =
          await _auth.signUpWithEmailAndPassword(email.text, pass.text);
      UserModel newUser = UserModel(
        ref: FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential!.uid),
        createdTime: DateTime.now(),
        displayName: fullName.text,
        email: email.text,
        interests: selectedTags,
        uid: userCredential.uid,
        username: username.text,
        photoUrl: null,
        bannerUrl: null,
      );
      await _auth.addUser(newUser);
      Get.offAllNamed(RouteName.start);
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading.value = false;
  }

  Future<void> verifyEmail() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    await _auth.sendOTP(email.text);
    Get.toNamed(RouteName.verify);
    isLoading.value = false;
    update();
  }

  Future<void> verifyOTP() async {
    isLoading.value = true;
    bool isVerified = await _auth.checkOTP(inputOTP.value);
    if (isVerified) {
      isLoading.value = false;
      Get.toNamed(RouteName.tagInterest);
    } else {
      isLoading.value = false;
      SnackBarWidget.showSnackBar(false, "otp_verification_failed".tr);
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
