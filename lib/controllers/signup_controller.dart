import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../routes/route_name.dart';
import '../repositories/auth.dart';
import '../utils/cancellation.dart';
import 'login_controller.dart';

class SignupController extends GetxController {
  late final LoginController _loginController;
  final _auth = Auth();
  CancellationToken _cancellationToken = CancellationToken();
  late TextEditingController username;
  late TextEditingController fullName;
  late TextEditingController email;
  late TextEditingController pass;
  late TextEditingController confPass;

  late FocusNode focusNode;
  late FocusNode confirmPassfocusNode;
  User? userCredential;
  RxBool isVisible = true.obs;
  RxBool isConfirmPassVisible = true.obs;
  RxBool isFocused = false.obs;
  RxBool isConfirmPassFocused = false.obs;
  RxBool isLoading = false.obs;
  RxBool isFullNameInvalid = false.obs;
  RxBool isUsernameInvalid = false.obs;
  RxBool isEmailInvalid = false.obs;
  RxBool isPassInvalid = false.obs;
  RxBool isConfPassInvalid = false.obs;

  @override
  void onInit() {
    _loginController = Get.find<LoginController>();
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

  Future<void> signup(LoginProvider loginProvider) async {
    if (_cancellationToken.isCancelled) return;
    _cancellationToken.cancel();
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 2000));
    try {
      if (loginProvider == LoginProvider.google) {
        await _signUpWithGoogle();
      } else if (loginProvider == LoginProvider.facebook) {
        await _auth.signInWithFacebook();
      } else if (loginProvider == LoginProvider.email) {
        await _signUpWithEmailAndPass();
      }
    } catch (e) {
      _cancellationToken = CancellationToken();
    }
    _cancellationToken = CancellationToken();
    isLoading.value = false;
    update();
  }

  Future<void> _signUpWithEmailAndPass() async {
    isLoading.value = true;
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
        interests: _loginController.selectedTags,
        uid: userCredential.uid,
        username: "@${username.text}",
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

  Future<void> _signUpWithGoogle() async {
    isLoading.value = true;
    try {
      UserModel newUser = UserModel(
        ref: FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential!.uid),
        createdTime: DateTime.now(),
        displayName: userCredential!.displayName!,
        email: userCredential!.email!,
        interests: _loginController.selectedTags,
        uid: userCredential!.uid,
        username: "@${username.text}",
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
    if (loginProvider == LoginProvider.email) {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 1000));
      await _auth.sendOTP(email.text);
      Get.toNamed(RouteName.verify);
      isLoading.value = false;
    } else if (loginProvider == LoginProvider.google) {
        isLoading.value = true;
      userCredential = await _auth.signInWithGoogle();
      if (userCredential != null) {
        await Future.delayed(const Duration(milliseconds: 1000));
        await _auth.sendOTP(userCredential!.email!);
        Get.toNamed(RouteName.verify);
        isLoading.value = false;
      }
    }
    update();
  }
}
