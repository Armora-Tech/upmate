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

  static bool isPassValid(TextEditingController pass) {
    return pass.text.trim().length >= minPassLength &&
        pass.text.trim().length <= maxPassLength;
  }

  static bool isUsernameLengthValid(TextEditingController username) {
    return username.text.trim().length >= minUsernameLength &&
        username.text.trim().length <= maxUsernameLength;
  }

  static bool isUsernameFormatValid(TextEditingController username) {
    bool isLowerCase = username.text == username.text.trim().toLowerCase();
    bool hasNoSpaces = !username.text.trim().contains(' ');

    return isLowerCase && hasNoSpaces;
  }

  static bool isFullNameValid(TextEditingController fullName) {
    return fullName.text.trim().length >= minFullNameLength &&
        fullName.text.trim().length <= maxFullNameLength;
  }

  static RxString? passValidationMessage(TextEditingController pass) {
    if (!isPassValid(pass)) {
      return minMessage("Password", minPassLength);
    } else {
      return null;
    }
  }

  static RxString? confPassValidationMessage(
      TextEditingController confPass, TextEditingController pass) {
    if (!isPassValid(confPass)) {
      return minMessage("Konfirmasi Password", minPassLength);
    } else if ((confPass.text.trim().trim() != pass.text.trim().trim()) &&
        isPassValid(confPass) &&
        isPassValid(pass)) {
      return "Password dan konfirmasi password harus sama".obs;
    } else {
      return null;
    }
  }

  static RxString? emailValidationMessage(TextEditingController email) {
    if (!email.text.trim().isEmail) {
      return "Format email tidak valid".obs;
    } else {
      return null;
    }
  }

  static RxString? usernameValidationMessage(TextEditingController username) {
    if (!isUsernameLengthValid(username)) {
      return minMessage("Nama pengguna", minUsernameLength);
    } else {
      if (!isUsernameFormatValid(username)) {
        return "Nama pengguna harus terdiri dari huruf kecil tanpa spasi".obs;
      }
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
