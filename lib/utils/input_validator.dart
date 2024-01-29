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
  static final String fullNameInput = "full_name".tr;
  static final String usernameInput = "username".tr;
  static const String emailInput = "email";
  static final String passInput = "password".tr;
  static final String confPassInput = "confirm_password".tr;

  static String minMessage(String input, int length) {
    String firstCharUpperCase =
        input[0].toUpperCase() + input.substring(1).toLowerCase();
    if (Get.locale!.languageCode == 'id') {
      return "$firstCharUpperCase minimal $length karakter";
    } else {
      return "$firstCharUpperCase at least $length characters";
    }
  }

  static String emptyInputMessage(String input) {
    String firstCharUpperCase =
        input[0].toUpperCase() + input.substring(1).toLowerCase();
    if (Get.locale!.languageCode == 'id') {
      return "$firstCharUpperCase tidak boleh kosong";
    } else {
      return "$firstCharUpperCase must not be empty";
    }
  }

  static String? usernameMessageValidation(String? value, dynamic controller) {
    if (value!.isEmpty) {
      controller.isUsernameInvalid.value = true;
      controller.update();
      return emptyInputMessage(usernameInput);
    } else if (value.length < minUsernameLength) {
      controller.isUsernameInvalid.value = true;
      controller.update();
      return minMessage(usernameInput, minUsernameLength);
    } else if (!RegExp(r'^[a-z_]+$').hasMatch(value)) {
      return "username_must_be_in_all_lowercase_letters_and_without_spaces".tr;
    }
    controller.isUsernameInvalid.value = false;
    controller.update();
    return null;
  }

  static String? fullNameMessageValidation(String? value, dynamic controller) {
    if (value!.isEmpty) {
      controller.isFullNameInvalid.value = true;
      controller.update();
      return emptyInputMessage(fullNameInput);
    } else if (value.length < minFullNameLength) {
      controller.isFullNameInvalid.value = true;
      controller.update();
      return minMessage(fullNameInput, minFullNameLength);
    }
    controller.isFullNameInvalid.value = false;
    controller.update();
    return null;
  }

  static String? emailMessageValidation(String? value, dynamic controller) {
    if (value!.isEmpty) {
      controller.isEmailInvalid.value = true;
      controller.update();
      return emptyInputMessage(emailInput);
    } else if (!value.isEmail) {
      return "invalid_email_format".tr;
    }
    controller.isEmailInvalid.value = false;
    controller.update();
    return null;
  }

  static String? passMessageValidation(String? value, dynamic controller) {
    if (value!.isEmpty) {
      controller.isPassInvalid.value = true;
      controller.update();
      return emptyInputMessage(passInput);
    } else if (value.length < minPassLength) {
      controller.isPassInvalid.value = true;
      controller.update();
      return minMessage(passInput, minPassLength);
    }
    controller.isPassInvalid.value = false;
    controller.update();
    return null;
  }

  static String? confPassMessageValidation(String? value, dynamic controller) {
    if (value!.isEmpty) {
      controller.isConfPassInvalid.value = true;
      controller.update();
      return emptyInputMessage(confPassInput);
    } else if (value.length < minPassLength) {
      controller.isConfPassInvalid.value = true;
      controller.update();
      return minMessage(confPassInput, minPassLength);
    } else if (controller.pass.text.trim() != controller.confPass.text.trim()) {
      return "password_and_conf_pass_must_be_the_same".tr;
    }
    controller.isConfPassInvalid.value = false;
    controller.update();
    return null;
  }
}
