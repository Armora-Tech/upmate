import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:upmatev2/models/chat_message_model.dart';
import 'package:upmatev2/models/chat_model.dart';
import 'package:upmatev2/models/user_model.dart';

import 'auth.dart';

class ChatRepository {
  final Auth _auth = Auth();

  Future<bool> isNewChat(ChatModel chatModel) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('chats')
          .where('users', arrayContains: chatModel.userRaw[0])
          .withConverter(
              fromFirestore: ChatModel.fromFirestore,
              toFirestore: (ChatModel chat, _) => chat.toFirestore())
          .get();
      debugPrint("ACC: ${chatModel.userRaw}");
      bool isNew = true;
      for (var data in querySnapshot.docs) {
        var dataChat = data.data() as ChatModel;
        debugPrint("RES: ${dataChat.userRaw}");
        if (dataChat.userRaw.contains(chatModel.userRaw[0]) &&
            dataChat.userRaw.contains(chatModel.userRaw[1])) isNew = false;
      }
      return isNew;
    } catch (e) {
      debugPrint("ERROR : $e");
      return false;
    }
  }

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
      await chatMessageModel.chatRef.update({
        "last_message": chatMessageModel.text,
        "last_message_time": chatMessageModel.timestamp
      });
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

  Future<List<ChatMessageModel>> getChatMessages(
      DocumentReference docRef) async {
    try {
      List<ChatMessageModel> datas = [];

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('chat_messages')
          .where('chat', isEqualTo: docRef)
          .orderBy("timestamp", descending: true)
          .withConverter(
              fromFirestore: ChatMessageModel.fromFirestore,
              toFirestore: (ChatMessageModel chatMessageModel, _) =>
                  chatMessageModel.toFirestore())
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

  Future<List<UserModel>> getContact() async {
    final user = await _auth.getUserModel();
    List<UserModel> datas = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where('interests', arrayContainsAny: user?.interests)
        .withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (UserModel user, _) => user.toFirestore())
        .get();

    for (var data in querySnapshot.docs) {
      var dataUser = data.data() as UserModel;
      datas.add(dataUser);
    }

    return datas;
  }

  Stream<List<ChatModel>> getChatsStream() {
    DocumentReference docRef = _auth.getCurrentUserReference();

    return FirebaseFirestore.instance
        .collection('chats')
        .where('users', arrayContains: docRef)
        .withConverter(
            fromFirestore: ChatModel.fromFirestore,
            toFirestore: (ChatModel chat, _) => chat.toFirestore())
        .snapshots()
        .asyncMap((chats) async {
      List<ChatModel> datas = [];
      for (var data in chats.docs) {
        var chat = data.data() as ChatModel;
        debugPrint("CHAT: $chat");
        await chat.initUsers();
        datas.add(chat);
      }
      return datas;
    });
  }

  Stream<QuerySnapshot> getChatMessagesStream(DocumentReference docRef) {
    return FirebaseFirestore.instance
        .collection('chat_messages')
        .where('chat', isEqualTo: docRef)
        .orderBy("timestamp", descending: true)
        .withConverter(
            fromFirestore: ChatMessageModel.fromFirestore,
            toFirestore: (ChatMessageModel chatMessageModel, _) =>
                chatMessageModel.toFirestore())
        .snapshots();
  }
}
