import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../repositories/auth.dart';
import '../routes/route_name.dart';
import '../utils/cancellation.dart';
import '../widgets/global/snack_bar.dart';

enum LoginProvider { email, google, facebook }

class LoginController extends GetxController {
  final Auth _auth = Auth();
  CancellationToken _cancellationToken = CancellationToken();
  late TextEditingController email;
  late TextEditingController pass;
  late FocusNode focusNode;
  late TextEditingController edtTagInterest;
  User? userCredential;
  LoginProvider? selectedLoginProvider;
  RxBool isEmptyText = true.obs;
  RxBool isEmailInvalid = false.obs;
  RxBool isPassInvalid = false.obs;
  RxBool isVisible = true.obs;
  RxBool isFocused = false.obs;
  RxBool isLoading = false.obs;
  RxString inputOTP = "".obs;
  RxBool isLogin = true.obs;

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
    email = TextEditingController();
    pass = TextEditingController();
    focusNode = FocusNode();
    edtTagInterest = TextEditingController();
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
    edtTagInterest.dispose();
    super.onClose();
  }

  Future<void> login(LoginProvider loginProvider) async {
    if (_cancellationToken.isCancelled) return;
    _cancellationToken.cancel();
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 2000));
    try {
      if (loginProvider == LoginProvider.google) {
        await _signInWithGoogle();
      } else if (loginProvider == LoginProvider.facebook) {
        await _auth.signInWithFacebook();
      } else if (loginProvider == LoginProvider.email) {
        await _auth.signInWithEmailAndPassword(email.text, pass.text);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      _cancellationToken = CancellationToken();
    }
    _cancellationToken = CancellationToken();
    isLoading.value = false;
    update();
  }

  Future<void> _signInWithGoogle() async {
    isLoading.value = true;
    try {
      UserModel newUser = UserModel(
        ref: FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential!.uid),
        createdTime: DateTime.now(),
        displayName: userCredential!.displayName!,
        email: userCredential!.email!,
        interests: selectedTags,
        uid: userCredential!.uid,
        username:
            "@${userCredential!.displayName!.replaceAll(" ", "").toLowerCase()}",
        photoUrl: userCredential!.photoURL,
        bannerUrl: null,
      );
      await _auth.addUser(newUser);
      Get.offAllNamed(RouteName.start);
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading.value = false;
  }

  Future<void> verifyEmail(LoginProvider loginProvider) async {
    userCredential = await _auth.signInWithGoogle();
    if (userCredential != null) {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 1000));
      await _auth.sendOTP(userCredential!.email!);
      Get.toNamed(RouteName.verify);
      isLoading.value = false;
    }
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

  Future<void> signOut() async {
    isLoading.value = true;
    try {
      await _auth.signOut();
      isLoading.value = false;
      update();
      Get.offAllNamed(RouteName.login);
      Get.forceAppUpdate();
    } catch (e) {
      if (kDebugMode) {
        print('Error navigating to start page: $e');
        print("Sign out failed!");
      }
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
