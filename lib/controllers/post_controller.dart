import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  late TextEditingController description;
  late FocusNode focusNode;
  RxBool isCover = false.obs;

  @override
  void onInit() {
    focusNode = FocusNode();
    description = TextEditingController();
    focusNode.addListener(() {});
    update();
    super.onInit();
  }

  @override
  void dispose() {
    focusNode.dispose();
    description.dispose();
    super.dispose();
  }
}
