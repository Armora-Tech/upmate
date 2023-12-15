import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarWidget {
  static SnackbarController showSnackBar(
      String title, String message, Color color) {
    return Get.snackbar(title, message,
        colorText: color,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10));
  }
}
