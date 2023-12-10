import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  late final TextEditingController textEditingController;

  Map<String, dynamic> data = {
    "Nama Pengguna": "Flora Shafiqa",
    "Nama Lengkap": "Flora Shafiqa Riyadi",
    "Bio": "",
    "Email": "flora@gmail.com",
    "Password": "*****"
  };

  List<int> maxLength = [15, 20, 60, 30, 12];

  @override
  void onInit() {
    textEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}
