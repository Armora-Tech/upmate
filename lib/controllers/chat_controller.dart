import 'package:get/get.dart';

class ChatController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isShowSearch = false.obs;

  Future<void> loading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    isLoading.value = false;
  }

  
}