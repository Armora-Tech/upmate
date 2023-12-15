import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/auth.dart';
import '../utils/cancellation.dart';
import '../utils/input_validator.dart';

enum LoginProvider { email, google, facebook }

class LoginController extends GetxController {
  final Auth _auth = Auth();
  CancellationToken _cancellationToken = CancellationToken();

  late TextEditingController email;
  late TextEditingController pass;
  late FocusNode focusNode;
  RxString? errorEmailMessage;
  RxString? errorPassMessage;
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
    inputValidation();
    if (_cancellationToken.isCancelled) return;
    _cancellationToken.cancel();
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 2000));
    try {
      if (loginProvider == LoginProvider.google) {
        await _auth.signInWithGoogle();
      } else if (loginProvider == LoginProvider.facebook) {
        await _auth.signInWithFacebook();
      } else if (isInputValid().value && loginProvider == LoginProvider.email) {
        await _auth.signInWithEmailAndPassword(
          email.text,
          pass.text,
        );
      }
      email.clear();
      pass.clear();
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
    try {
      await _auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print('Error navigating to start page: $e');
        print("Sign out failed!");
      }
    }
    errorEmailMessage = null;
    errorPassMessage = null;
    isLoading.value = false;
  }

  void inputValidation() {
    errorEmailMessage = InputValidator.emailValidationMessage(email);
    errorPassMessage = InputValidator.passValidationMessage(pass);
  }

  RxBool isInputValid() =>
      (email.text.isEmail && InputValidator.isPassValid(pass)).obs;
}
