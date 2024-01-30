import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/models/chat_message_model.dart';
import 'package:upmatev2/repositories/chat_repository.dart';
import 'package:upmatev2/utils/pick_image.dart';

import '../repositories/auth.dart';
import '../routes/route_name.dart';
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
  RxBool isLoading = true.obs;
  RxBool isSendingPicture = false.obs;
  RxBool isSendingMessage = false.obs;
  String? imgUrl;
  AsyncSnapshot<QuerySnapshot>? snapshot;

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
  }

  Future<void> sendChat() async {
    if (_cameraViewController.image != null &&
        _galleryController.selectedAssetList.isEmpty) {
      isSendingPicture.value = true;
      Get.forceAppUpdate();
      imgUrl = await Upload().uploadFromCamera(_cameraViewController);
      Get.until((route) => Get.previousRoute == RouteName.chatRoom);
    } else {
      isSendingMessage.value = true;
    }
    chatMessage = ChatMessageModel(
        ref: FirebaseFirestore.instance.collection("chat_messages").doc(),
        chat: _chatController.selectedChat!.ref,
        text: imgUrl == null ? textEditingController.text : "send_a_picture".tr,
        timestamp: DateTime.now(),
        user: _startController.user!.ref,
        image: imgUrl);
    textEditingController.clear();
    isTextFieldEmpty.value = true;
    imgUrl = null;
    _cameraViewController.image = null;
    _galleryController.selectedAssetList.clear();
    await ChatRepository().addMessage(chatMessage!);
    isSendingPicture.value = false;
    isSendingMessage.value = false;
    Get.forceAppUpdate();
  }

  Future<void> sendImageFromGallery() async {
    Get.back();
    for (var asset in _galleryController.selectedAssetList) {
      try {
        Get.forceAppUpdate();
        isSendingPicture.value = true;
        File? assetData = await asset.loadFile();
        final Directory tempDir = await getTemporaryDirectory();
        File newAsset = File(
            "${tempDir.path}/IMG-${Auth().getCurrentUserReference().id}${DateTime.now()}");
        await newAsset.create();
        List<int> bytes = await assetData!.readAsBytes();

        final uint8List = Uint8List.fromList(bytes);
        final result = await PickImage().compressImage(uint8List);
        newAsset.writeAsBytesSync(result!);
        final response = await Upload().uploadImage(newAsset);

        if (response.statusCode == 200) {
          final responseData = response.body;
          final jsonResponse = jsonDecode(responseData);
          imgUrl = (jsonResponse['url']);
          chatMessage = ChatMessageModel(
              ref: FirebaseFirestore.instance.collection("chat_messages").doc(),
              chat: _chatController.selectedChat!.ref,
              text: "send_a_picture".tr,
              timestamp: DateTime.now(),
              user: _startController.user!.ref,
              image: imgUrl);
          await ChatRepository().addMessage(chatMessage!);
          isSendingPicture.value = false;
          Get.forceAppUpdate();
        } else {
          //error
          return;
        }
      } catch (error) {
        return;
      }
    }
    textEditingController.clear();
    imgUrl = null;
    _cameraViewController.image = null;
    _galleryController.selectedAssetList.clear();
    isTextFieldEmpty.value = true;
  }

// cek apakah user yang mengirimkan chat?
  bool isUser(int index) {
    final data = snapshot!.data!.docs[index].data() as ChatMessageModel;
    return data.owner.id == _startController.user!.ref.id;
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
    final data = snapshot!.data!.docs;
    debugPrint("keng: ${data.length - 1}");
    // chatnya user
    if (isUser(index)) {
      if (index == 0) {
        marginTop.value = 0;
        marginBottom.value = 0;
      } else if (!isUser(index - 1)) {
        marginTop.value = 0;
        marginBottom.value = 10;
      } else {
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
      } else if (isUser(index - 1)) {
        marginTop.value = 0;
        marginBottom.value = 10;
      } else {
        marginTop.value = 0;
        marginBottom.value = 0;
      }
    }
  }

// function untuk mengatur border radius border chatnya
  BorderRadius checkPositionedUserChat(int index) {
    final data = snapshot!.data!.docs;
    // konsepnya sama seperti yang diatas bedanya dia ngereturn borderRadius
    if (isUser(index)) {
      if (index == 0) {
        return initialUserChatBorder();
      } else if (index == data.length - 1) {
        return finalUserChatBorder();
      } else if (index != 0 && !isUser(index - 1)) {
        return initialUserChatBorder();
      } else if (index != data.length - 1 && !isUser(index + 1)) {
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
      } else if (index == data.length - 1) {
        return finalOtherChatBorder();
      } else if (index != 0 && isUser(index - 1)) {
        return initialOtherChatBorder();
      } else if (index != data.length - 1 && isUser(index + 1)) {
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
}
