import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/chat_model.dart';
import '../repositories/auth.dart';

class ChatController extends GetxController {
  final Auth _auth = Auth();
  RxBool isLoading = true.obs;
  RxBool isShowSearch = false.obs;

  Future<void> loading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    isLoading.value = false;
  }


}
