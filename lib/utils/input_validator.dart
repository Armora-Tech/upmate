import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputValidator {
  static Locale currentLocale = Get.locale!;
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
    String firstCharUpperCase =
        input[0].toUpperCase() + input.substring(1).toLowerCase();
    if (currentLocale.languageCode == 'id') {
      return "$firstCharUpperCase minimal $length karakter".obs;
    } else {
      return "$firstCharUpperCase at least $length characters".obs;
    }
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
      return minMessage("password".tr, minPassLength);
    } else {
      return null;
    }
  }

  static RxString? confPassValidationMessage(
      TextEditingController confPass, TextEditingController pass) {
    if (!isPassValid(confPass)) {
      return minMessage("confirm_password".tr, minPassLength);
    } else if ((confPass.text.trim().trim() != pass.text.trim().trim()) &&
        isPassValid(confPass) &&
        isPassValid(pass)) {
      return "password_and_conf_pass_must_be_the_same".tr.obs;
    } else {
      return null;
    }
  }

  static RxString? emailValidationMessage(TextEditingController email) {
    if (!email.text.trim().isEmail) {
      return "invalid_email_format".tr.obs;
    } else {
      return null;
    }
  }

  static RxString? usernameValidationMessage(TextEditingController username) {
    if (!isUsernameLengthValid(username)) {
      return minMessage("username".tr, minUsernameLength);
    } else {
      if (!isUsernameFormatValid(username)) {
        return "username_must_consist_of_lowercase_letters_without_spaces"
            .tr
            .obs;
      }
      return null;
    }
  }

  static RxString? fullNameValidationMessage(TextEditingController fullName) {
    if (!isFullNameValid(fullName)) {
      return minMessage("full_name".tr, minFullNameLength);
    } else {
      return null;
    }
  }
}
