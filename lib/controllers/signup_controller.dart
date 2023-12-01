import 'package:get/get.dart';

class SignupController extends GetxController {
  RxBool isVisible = true.obs;
  RxBool isConfirmPassVisible = true.obs;

  void changeVisibility() {
    isVisible.value = !isVisible.value;
  }

  void changeConfirmPassVisibility() {
    isConfirmPassVisible.value = !isConfirmPassVisible.value;
  }
}
