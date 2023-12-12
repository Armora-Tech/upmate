import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/auth.dart';
import '../utils/cancellation.dart';

enum LoginProvider { email, google, facebook }

class LoginController extends GetxController {
  final Auth _auth = Auth();
  CancellationToken _cancellationToken = CancellationToken();

  late TextEditingController email;
  late TextEditingController pass;
  late FocusNode focusNode;
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

  Future<void> login(BuildContext context, LoginProvider loginProvider) async {
    if (_cancellationToken.isCancelled) return;
    _cancellationToken.cancel();
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    try {
      if (loginProvider == LoginProvider.email) {
        await _auth.signInWithEmailAndPassword(
            this.email.text, this.pass.text, context);
      } else if (loginProvider == LoginProvider.google) {
        await _auth.signInWithGoogle(context);
      } else if (loginProvider == LoginProvider.facebook) {
        await _auth.signInWithFacebook(context);
      }
    }catch(e){
      if (kDebugMode) {
        print("Error: $e");
      }
      _cancellationToken = CancellationToken();
    }
    isLoading.value = false;
    _cancellationToken = CancellationToken();
  }

  void changeVisibility() {
    isVisible.toggle();
  }
}
