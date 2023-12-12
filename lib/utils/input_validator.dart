import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputValidator {
  static const int minPassLength = 6;
  static const int maxPassLength = 32;
  static const int minUsernameLength = 5;
  static const int maxUsernameLength = 30;
  static const int minFullNameLength = 3;
  static const int maxFullNameLength = 100;
  static const int maxBioLength = 200;
  static const int maxDescLength = 200;

  static RxString minMessage(String input, int length) {
    return "$input minimal $length karakter".obs;
  }

  static bool isPassValid(TextEditingController pass) {
    return pass.text.length >= minPassLength &&
        pass.text.length <= maxPassLength;
  }

  static bool isUsernameValid(TextEditingController username) {
    return username.text.length >= minUsernameLength &&
        username.text.length <= maxUsernameLength;
  }

  static bool isFullNameValid(TextEditingController fullName) {
    return fullName.text.length >= minFullNameLength &&
        fullName.text.length <= maxFullNameLength;
  }

  static RxString? passValidationMessage(TextEditingController pass) {
    if (!isPassValid(pass)) {
      return minMessage("Password", minPassLength);
    } else {
      return null;
    }
  }

  static RxString? confPassValidationMessage(TextEditingController confPass) {
    if (!isPassValid(confPass)) {
      return minMessage("Konfirmasi Password", minPassLength);
    } else {
      return null;
    }
  }

  static RxString? emailValidationMessage(TextEditingController email) {
    if (!email.text.isEmail) {
      return "Format email tidak valid".obs;
    } else {
      return null;
    }
  }

  static RxString? usernameValidationMessage(TextEditingController username) {
    if (!isUsernameValid(username)) {
      return minMessage("Username", minUsernameLength);
    } else {
      return null;
    }
  }

  static RxString? fullNameValidationMessage(TextEditingController fullName) {
    if (!isFullNameValid(fullName)) {
      return minMessage("FullName", minFullNameLength);
    } else {
      return null;
    }
  }
}
