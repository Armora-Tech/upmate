import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/login_controller.dart';
import 'package:upmatev2/themes/app_font.dart';

class ConfirmLogoutDialog {
  static void showDialog() {
    final controller = Get.find<LoginController>();
    Get.defaultDialog(
      title: "are_you_sure_you_want_to_logout".tr,
      titlePadding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      titleStyle: const TextStyle(color: Colors.black, fontSize: 16),
      content: const Text(""),
      actions: [
        ElevatedButton(
          onPressed: () => Get.back(),
          child: Text("cancel".tr,
              style: AppFont.text14.copyWith(color: Colors.white)),
        ),
        const SizedBox(width: 15),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
          onPressed: () async => await controller.signOut(),
          child: Text("logout".tr,
              style: AppFont.text14.copyWith(color: Colors.white)),
        ),
      ],
    );
  }
}
