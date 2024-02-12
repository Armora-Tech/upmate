import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/tag_interest_controller.dart';
import '../models/user_model.dart';
import '../repositories/auth.dart';
import '../routes/route_name.dart';
import '../utils/cancellation.dart';

enum LoginProvider { email, google, facebook }

class LoginController extends GetxController {
  TagInterestController? _tagInterestController;
  late TextEditingController email;
  late TextEditingController pass;
  late FocusNode focusNode;
  final Auth _auth = Auth();
  User? userCredential;
  CancellationToken _cancellationToken = CancellationToken();
  RxBool isEmailInvalid = false.obs;
  RxBool isPassInvalid = false.obs;
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

  Future<void> login(LoginProvider loginProvider) async {
    if (_cancellationToken.isCancelled) return;
    _cancellationToken.cancel();
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 2000));
    try {
      if (loginProvider == LoginProvider.google) {
        userCredential = await _auth.signInWithGoogle();
        await verifyEmail();
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

  Future<void> signInWithGoogle() async {
    _tagInterestController = Get.find<TagInterestController>();
    try {
      _tagInterestController!.isLoading.value = true;
      UserModel newUser = UserModel(
        ref: FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential!.uid),
        createdTime: DateTime.now(),
        displayName: userCredential!.displayName!,
        email: email.text,
        interests: _tagInterestController!.selectedTags,
        uid: userCredential!.uid,
        username:
            userCredential!.displayName!.replaceAll(" ", "").toLowerCase(),
        photoUrl: null,
        bannerUrl: null,
      );
      await _auth.addUser(newUser);
      Get.offAllNamed(RouteName.start);
    } catch (e) {
      rethrow;
    }
    _tagInterestController!.isLoading.value = false;
  }

  Future<void> verifyEmail() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    await _auth.sendOTP(userCredential!.email!);
    Get.toNamed(RouteName.verify, arguments: true);
    isLoading.value = false;
    update();
  }

  Future<void> signOut() async {
    isLoading.value = true;
    try {
      await _auth.signOut();
      update();
      Get.offAllNamed(RouteName.login);
      Get.forceAppUpdate();
      isLoading.value = false;
    } catch (e) {
      if (kDebugMode) {
        print('Error navigating to start page: $e');
        print("Sign out failed!");
      }
    }
    Get.forceAppUpdate();
  }
}
