import 'package:get/get.dart';

class NotificationController extends GetxController{
   RxBool isLoading = true.obs;

  Future<void> loading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    isLoading.value = false;
  }
}