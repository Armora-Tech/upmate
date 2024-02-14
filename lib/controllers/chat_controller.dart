import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/models/chat_model.dart';
import 'package:upmatev2/models/user_model.dart';
import 'package:upmatev2/repositories/chat_repository.dart';
import 'package:upmatev2/routes/route_name.dart';

class ChatController extends GetxController {
  late final StartController _startController;
  late final Stream<List<ChatModel>> chatStream;
  List<UserModel> listSearchResult = [];
  late final TextEditingController searchText;
  List<ChatModel> chats = [];
  List<UserModel> contacts = [];
  ChatModel? selectedChat;
  UserModel? selectedContact;
  RxBool isLoading = false.obs;
  RxBool isShowSearch = false.obs;
  RxBool isSearchTextEmpty = true.obs;

  @override
  Future<void> onInit() async {
    _startController = Get.find<StartController>();
    searchText = TextEditingController();
    await _getChats();
    chatStream = ChatRepository().getChatsStream();
    listSearchResult = List.from(contacts);
    super.onInit();
  }

  @override
  void onClose() {
    searchText.dispose();
    super.onClose();
  }

  Future<void> createChat() async {
    isLoading.value = true;
    ChatModel chatModel = ChatModel(
        ref: FirebaseFirestore.instance.collection("chats").doc(),
        lastMessage: "",
        lastMessageTime: DateTime.now(),
        usersRaw: [
          _startController.user!.ref as DocumentReference<Map<String, dynamic>>,
          selectedContact!.ref as DocumentReference<Map<String, dynamic>>
        ]);
    final isNew = await ChatRepository().isNewChat(chatModel);
    if (isNew) {
      await ChatRepository().createChat(chatModel);
    }
    chats = await ChatRepository().getChats();
    for (var i in chats) {
      if (i.chatRecipient!.uid == selectedContact!.uid) {
        selectedChat = i;
        Get.toNamed(RouteName.chatRoom);
      }
    }
    isLoading.value = false;
    update();
  }

  Future<void> _getChats() async {
    isLoading.value = true;
    chats = await ChatRepository().getChats();
    contacts = await ChatRepository().getContact();
    listSearchResult = List.from(contacts);
    isLoading.value = false;
    update();
  }

  void handleSearch(String text) {
    if (text.isNotEmpty) {
      isSearchTextEmpty.value = false;
    } else {
      isSearchTextEmpty.value = true;
    }
    listSearchResult = contacts
        .where((element) =>
            element.displayName.toLowerCase().contains(text.toLowerCase()))
        .toList();
    update();
  }

  void back() {
    searchText.clear();
    isSearchTextEmpty.value = true;
    listSearchResult = List.from(contacts);
  }
}
