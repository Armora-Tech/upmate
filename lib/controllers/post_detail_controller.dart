import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostDetailController extends GetxController {
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  RxInt selectedIndex = 0.obs;
  RxBool isTextFieldEmpty = true.obs;
  RxBool isShowEmoji = false.obs;

  @override
  void onInit() {
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isShowEmoji.value = false;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
