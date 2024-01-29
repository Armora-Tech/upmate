import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../repositories/auth.dart';
import '../routes/route_name.dart';
import '../utils/cancellation.dart';

enum LoginProvider { email, google, facebook }

class LoginController extends GetxController {
  final Auth _auth = Auth();
  CancellationToken _cancellationToken = CancellationToken();
  late TextEditingController email;
  late TextEditingController pass;
  late FocusNode focusNode;
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
        final userCredential = await _auth.signInWithGoogle();
        _auth.getCurrentUserReference();
        final UserModel? user = await _auth.getUserModel();
        if (userCredential != null && user!.interests.isNotEmpty) {
          Get.offAllNamed(RouteName.start);
        }
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
}
