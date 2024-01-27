import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/models/chat_message_model.dart';
import 'package:upmatev2/repositories/chat_repository.dart';

import '../utils/upload.dart';
import 'camera_controller.dart';
import 'chat_controller.dart';
import 'gallery_controller.dart';

class ChatRoomController extends GetxController with WidgetsBindingObserver {
  late final GalleryController _galleryController;
  late final StartController _startController;
  late final CameraViewController _cameraViewController;
  late final ChatController _chatController;
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  RxDouble defaultRadius = 20.0.obs;
  RxDouble taperRadius = 3.0.obs;
  RxDouble marginTop = 0.0.obs;
  RxDouble marginBottom = 0.0.obs;
  RxBool isTextFieldEmpty = true.obs;
  RxBool isShowEmoji = false.obs;
  RxBool isImage = false.obs;
  RxBool isLoading = true.obs;

  late QuerySnapshot querySnapshot;
  List<ChatMessageModel> chats = [];
  ChatMessageModel? chatMessage;

  @override
  void onInit() async {
    WidgetsBinding.instance.addObserver(this);
    _galleryController = Get.find<GalleryController>();
    _startController = Get.find<StartController>();
    _cameraViewController = Get.find<CameraViewController>();
    _chatController = Get.find<ChatController>();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isShowEmoji.value = false;
      }
    });
    await _getChatMessages();
    isLoading.value = false;
    update();
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    textEditingController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  Future<void> _getChatMessages() async {
    chats = await ChatRepository()
        .getChatMessages(_chatController.selectedChat!.ref);
    debugPrint(
        "wadaw contactdesti: ${_chatController.selectedContactChat!.displayName}");
    debugPrint(
        "wadaw user: ${_chatController.selectedChat!.users![0].displayName}");
    debugPrint(
        "wadaw other: ${_chatController.selectedChat!.users![1].displayName}");
    debugPrint("wadaw=======================\n");
  }

  Future<void> sendChat() async {
    String? imgUrl;
    if (_cameraViewController.image == null) {
      for (var asset in _galleryController.selectedAssetList) {
        try {
          final response = await Upload().uploadImage(asset);
          if (response.statusCode == 200) {
            final responseData = response.body;
            final jsonResponse = jsonDecode(responseData);
            imgUrl = (jsonResponse['url']);
          } else {
            //error
            return;
          }
        } catch (error) {
          return;
        }
      }
    } else if(_galleryController.image!=null){
      try {
        final response =
        await Upload().uploadImage(_cameraViewController.image);
        if (response.statusCode == 200) {
          final responseData = response.body;
          final jsonResponse = jsonDecode(responseData);
          imgUrl = (jsonResponse['url']);
        } else {
          //error
          return;
        }
      } catch (error) {
        return;
      }
    }

    chatMessage = ChatMessageModel(
        ref: FirebaseFirestore.instance.collection("chat_messages").doc(),
        chat: _chatController.selectedChat!.ref,
        text: textEditingController.text,
        timestamp: DateTime.now(),
        user: _startController.user!.ref,
        image: imgUrl);
    await ChatRepository().addMessage(chatMessage!);
    chats = await ChatRepository()
        .getChatMessages(_chatController.selectedChat!.ref);
    textEditingController.clear();
    isTextFieldEmpty.value = true;
    Get.forceAppUpdate();
  }

// cek apakah user yang mengirimkan chat?
  bool isUser(int index) {
    return chats[index].owner.id == _startController.user!.ref.id;
  }

// function yang mengembalikan border radius yang
// lancip pada bagian kanan bawah pada chat user
  BorderRadius initialUserChatBorder() {
    return BorderRadius.only(
        topLeft: Radius.circular(defaultRadius.value),
        topRight: Radius.circular(taperRadius.value),
        bottomLeft: Radius.circular(defaultRadius.value),
        bottomRight: Radius.circular(defaultRadius.value));
  }

// function yang mengembalikan border radius yang
// lancip pada bagian kanan atas pada chat user
  BorderRadius finalUserChatBorder() {
    return BorderRadius.only(
        topLeft: Radius.circular(defaultRadius.value),
        bottomLeft: Radius.circular(defaultRadius.value),
        bottomRight: Radius.circular(taperRadius.value),
        topRight: Radius.circular(defaultRadius.value));
  }

// function yang mengembalikan border radius yang
// lancip pada bagian kiri bawah pada chat lawannya
  BorderRadius initialOtherChatBorder() {
    return BorderRadius.only(
        topLeft: Radius.circular(taperRadius.value),
        topRight: Radius.circular(defaultRadius.value),
        bottomRight: Radius.circular(defaultRadius.value),
        bottomLeft: Radius.circular(defaultRadius.value));
  }

// function yang mengembalikan border radius yang
// lancip pada bagian kanan bawah pada chat lawannya
  BorderRadius finalOtherChatBorder() {
    return BorderRadius.only(
        topRight: Radius.circular(defaultRadius.value),
        bottomLeft: Radius.circular(taperRadius.value),
        bottomRight: Radius.circular(defaultRadius.value),
        topLeft: Radius.circular(defaultRadius.value));
  }

// function untuk mengatur margin antara chat user dan lawannya
  void setMargin(int index) {
    // chatnya user
    if (isUser(index)) {
      if (index == 0) {
        marginTop.value = 0;
        marginBottom.value = 0;
      }
      // kalau sebelumnya chat lawan
      else if (index != 0 && !isUser(index - 1)) {
        marginTop.value = 10;
        marginBottom.value = 0;
      }
      // kalau setelahnya chat lawan
      else if (index != chats.length - 1 && !isUser(index + 1)) {
        marginBottom.value = 10;
        marginTop.value = 0;
      }
      // kalau chat sebelumnya dan setelahnya masih chatnya user
      else {
        marginTop.value = 0;
        marginBottom.value = 0;
      }
    }
    // chatnya lawannya
    else {
      // chat paling atas
      if (index == 0) {
        marginTop.value = 0;
        marginBottom.value = 0;
      }
      // kalau sebelumnya chat user
      else if (index != 0 && isUser(index - 1)) {
        marginTop.value = 10;
        marginBottom.value = 0;
      }
      // bawah beda
      else if (index != chats.length - 1 && isUser(index + 1)) {
        marginBottom.value = 10;
        marginTop.value = 0;
      }
      // kalau chat sebelumnya dan setelahnya masih chatnya lawan
      else {
        marginTop.value = 0;
        marginBottom.value = 0;
      }
    }
  }

// function untuk mengatur border radius border chatnya
  BorderRadius checkPositionedUserChat(int index) {
    // konsepnya sama seperti yang diatas bedanya dia ngereturn borderRadius
    if (isUser(index)) {
      if (index == 0) {
        return initialUserChatBorder();
      } else if (index == chats.length - 1) {
        return finalUserChatBorder();
      } else if (index != 0 && !isUser(index - 1)) {
        return initialUserChatBorder();
      } else if (index != chats.length - 1 && !isUser(index + 1)) {
        return finalUserChatBorder();
      } else {
        return BorderRadius.only(
            bottomLeft: Radius.circular(defaultRadius.value),
            topLeft: Radius.circular(defaultRadius.value),
            topRight: Radius.circular(taperRadius.value),
            bottomRight: Radius.circular(taperRadius.value));
      }
    } else {
      if (index == 0) {
        return initialOtherChatBorder();
      } else if (index == chats.length - 1) {
        return finalOtherChatBorder();
      } else if (index != 0 && isUser(index - 1)) {
        return initialOtherChatBorder();
      } else if (index != chats.length - 1 && isUser(index + 1)) {
        return finalOtherChatBorder();
      } else {
        return BorderRadius.only(
            topLeft: Radius.circular(taperRadius.value),
            bottomLeft: Radius.circular(taperRadius.value),
            bottomRight: Radius.circular(defaultRadius.value),
            topRight: Radius.circular(defaultRadius.value));
      }
    }
  }

  // List<Map<String, dynamic>> chats = [
  //   {"user": "P"},
  //   {"user": "Hallo bang"},
  //   {"user": "Apa kabar?"},
  //   {"other": "Alhamdulillah baik bang. Ada apa bang?"},
  //   {"other": "Ada apa bang?"},
  //   {"user": "ga jadi"},
  //   {
  //     "other":
  //         "Ok bang semoga hari anda senin terus, Ok bang semoga hari anda senin terus"
  //   },
  //   {
  //     "other":
  //         "Ok bang semoga hari anda senin terus, Ok bang semoga hari anda senin terus, Ok bang semoga hari anda senin terus"
  //   },
  //   {"other": "Ok bang semoga hari anda senin terus"},
  // ];
}
