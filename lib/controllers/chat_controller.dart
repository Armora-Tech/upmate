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

  Future<List<ChatModel>> getChats() async {
    try {
      DocumentReference docRef = _auth.getCurrentUserReference();
      List<ChatModel> datas = [];

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('chats')
          .where('users', arrayContains: docRef)
          .withConverter(
              fromFirestore: ChatModel.fromFirestore,
              toFirestore: (ChatModel chat, _) => chat.toFirestore())
          .get();

      for (var data in querySnapshot.docs) {
        var dataChat = data.data() as ChatModel;
        await dataChat.initUsers();
        datas.add(dataChat);
      }

      return datas;
    } catch (e) {
      print("Error completing: $e");
      // Handle the error or return an empty list, depending on your requirements.
      return [];
    }
  }
}
