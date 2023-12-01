import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isVisible = true.obs;

  void changeVisibility() {
    isVisible.value = !isVisible.value;
  }
}
