import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/routes/route_name.dart';
import '../repositories/auth.dart';
import '../utils/cancellation.dart';
import '../utils/input_validator.dart';

enum LoginProvider { email, google, facebook }

class LoginController extends GetxController {
  final Auth _auth = Auth();
  CancellationToken _cancellationToken = CancellationToken();

  late TextEditingController email;
  late TextEditingController pass;
  late FocusNode focusNode;
  String? errorEmailMessage;
  String? errorPassMessage;
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
        await _auth.signInWithGoogle().then((value) {
          errorEmailMessage = null;
          errorPassMessage = null;
        });
      } else if (loginProvider == LoginProvider.facebook) {
        await _auth.signInWithFacebook().then((value) {
          errorEmailMessage = null;
          errorPassMessage = null;
        });
      } else if (isInputValid().value && loginProvider == LoginProvider.email) {
        await _auth
            .signInWithEmailAndPassword(
          email.text,
          pass.text,
        )
            .then((value) {
          errorEmailMessage = null;
          errorPassMessage = null;
        });
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
    try {
      await _auth.signOut().then((value) => Get.offNamed(RouteName.login));
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
    errorEmailMessage = InputValidator.emailValidationMessage(email)?.value;
    errorPassMessage = InputValidator.passValidationMessage(pass)?.value;
  }

  RxBool isInputValid() =>
      (email.text.isEmail && InputValidator.isPassValid(pass)).obs;
}
