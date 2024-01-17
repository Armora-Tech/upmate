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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSuccess ? Icons.check : Icons.close,
                color: isSuccess ? Colors.greenAccent : Colors.redAccent,
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Text(
                  message,
                  style: AppFont.text14.copyWith(color: Colors.white),
                  overflow: TextOverflow.visible,
                ),
              )
            ],
          ),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10));
  }
}
