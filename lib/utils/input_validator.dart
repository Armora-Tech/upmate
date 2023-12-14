import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputValidator {
  static const int minPassLength = 6;
  static const int maxPassLength = 32;
  static const int minUsernameLength = 5;
  static const int maxUsernameLength = 30;
  static const int minFullNameLength = 3;
  static const int maxFullNameLength = 100;
  static const int minBioLength = 0;
  static const int maxBioLength = 200;
  static const int minDescLength = 0;
  static const int maxDescLength = 200;

  static RxString minMessage(String input, int length) {
    return "$input minimal $length karakter".obs;
  }

  static bool isValid(
      TextEditingController text, int? minLength, int? maxLength) {
    if (minLength == null || maxLength == null) {
      return text.text.isEmail;
    } else {
      return text.text.length >= minLength && text.text.length <= maxLength;
    }
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

  static RxString? validationMessage(
      String input, TextEditingController text, int? minLength) {
    if (!isValid(text, minLength, 0)) {
      if (minLength == null) {
        return "Format email tidak valid".obs;
      }
      return minMessage(input, minLength);
    } else {
      return null;
    }
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
      return minMessage("Nama Lengkap", minFullNameLength);
    } else {
      return null;
    }
  }
}
