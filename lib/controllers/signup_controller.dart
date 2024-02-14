import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/tag_interest_controller.dart';
import 'package:upmatev2/widgets/global/snack_bar.dart';
import '../models/user_model.dart';
import '../routes/route_name.dart';
import '../repositories/auth.dart';
import '../utils/cancellation.dart';
import 'login_controller.dart';

class SignupController extends GetxController {
  final _auth = Auth();
  late final TagInterestController _tagInterestController;
  late final LoginController _loginController;
  late TextEditingController username;
  late TextEditingController fullName;
  late TextEditingController email;
  late TextEditingController pass;
  late TextEditingController confPass;
  late FocusNode focusNode;
  late FocusNode confirmPassfocusNode;
  CancellationToken _cancellationToken = CancellationToken();
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

  Future<void> signUp(LoginProvider loginProvider) async {
    if (_cancellationToken.isCancelled) return;
    _cancellationToken.cancel();
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 2000));
    try {
      if (loginProvider == LoginProvider.google) {
        _loginController.userCredential = await _auth.signUpWithGoogle();
        _loginController.isNewUser.value =
            await _auth.isNewUser(_loginController.userCredential!.email!);
        _loginController.isNewUser.value
            ? Get.toNamed(RouteName.tagInterest, arguments: true)
            : Get.offAllNamed(RouteName.start);
      } else if (loginProvider == LoginProvider.facebook) {
        await _auth.signUpWithFacebook();
      } else if (loginProvider == LoginProvider.email) {
        _loginController.isNewUser.value = await _auth.isNewUser(email.text);
        if (_loginController.isNewUser.value) {
          await verifyEmail();
        } else {
          SnackBarWidget.showSnackBar(false, "email_has_been_registered".tr);
        }
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

  Future<void> signUpWithEmailAndPassword() async {
    _tagInterestController = Get.find<TagInterestController>();
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
        interests: _tagInterestController.selectedTags,
        uid: userCredential.uid,
        username: username.text,
        photoUrl: null,
        bannerUrl: null,
      );
      await _auth.addUser(newUser);
      Get.offAllNamed(RouteName.start);
    } catch (e) {
      debugPrint("ERROR $e");
      rethrow;
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
}
