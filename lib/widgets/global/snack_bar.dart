import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/themes/app_font.dart';

class SnackBarWidget {
  static SnackbarController showSnackBar(bool isSuccess, String message) {
    return Get.snackbar("", "",
        backgroundColor: Colors.black,
        maxWidth: 300,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        colorText: Colors.white,
        messageText: const SizedBox(),
        titleText: Center(
          child: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(
                    isSuccess ? Icons.check : Icons.close,
                    color: isSuccess ? Colors.greenAccent : Colors.redAccent,
                    size: 20,
                  ),
                ),
                const WidgetSpan(child: SizedBox(width: 5)),
                TextSpan(
                  text: message,
                  style: AppFont.text14.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10));
  }
}
