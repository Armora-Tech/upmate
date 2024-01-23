import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:upmatev2/models/chat_message_model.dart';
import 'package:upmatev2/models/chat_model.dart';

import '../models/post_model.dart';
import '../models/user_model.dart';
import 'auth.dart';

class ChatRepository {
  final Auth _auth = Auth();

  Future<void> createChat(ChatModel chatModel) async {
    try {
      await FirebaseFirestore.instance
          .collection("chats")
          .add(chatModel.toFirestore())
          .then((DocumentReference doc) => {
        if (kDebugMode)
          {debugPrint('DocumentSnapshot added with ID: ${doc.id}')}
      });
    } catch (e) {
      debugPrint("ERROR : $e");
    }
  }

  Future<void> addMessage(ChatMessageModel chatMessageModel) async {
    try {
      await FirebaseFirestore.instance
          .collection("chat_messages")
          .add(chatMessageModel.toFirestore())
          .then((DocumentReference doc) => {
                if (kDebugMode)
                  {debugPrint('DocumentSnapshot added with ID: ${doc.id}')}
              });
    } catch (e) {
      debugPrint("ERROR : $e");
    }
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

  Future<List<ChatMessageModel>> getChatMessages(DocumentReference docRef) async {
    try {
      List<ChatMessageModel> datas = [];

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('chat_messages')
          .where('chat', isEqualTo: docRef)
          .withConverter(
          fromFirestore: ChatMessageModel.fromFirestore,
          toFirestore: (ChatMessageModel chatMessageModel, _) => chatMessageModel.toFirestore())
          .get();

      for (var data in querySnapshot.docs) {
        var dataChat = data.data() as ChatMessageModel;
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
