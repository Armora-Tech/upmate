import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:upmatev2/utils/pick_image.dart';
import 'package:image/image.dart' as img;
import '../main.dart';

class ChatRoomController extends GetxController with WidgetsBindingObserver {
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  late CameraController cameraController;
  late void cameraValue;
  late FlashMode mode;
  File? image;
  RxDouble defaultRadius = 20.0.obs;
  RxDouble taperRadius = 3.0.obs;
  RxDouble marginTop = 0.0.obs;
  RxDouble marginBottom = 0.0.obs;
  RxBool isTextFieldEmpty = true.obs;
  RxBool isShowEmoji = false.obs;
  RxBool isImage = false.obs;
  RxBool isFlashOn = false.obs;
  RxBool isFrontCamera = true.obs;
  RxBool isTakingPicture = false.obs;
  RxInt cameraPositioned = 0.obs;

  AssetEntity? selectedEntity;
  List<AssetEntity> assetList = [];
  List<AssetEntity> selectedAssetList = [];

  List<Map<String, dynamic>> chats = [
    {"user": "P"},
    {"user": "Hallo bang"},
    {"user": "Apa kabar?"},
    {"other": "Alhamdulillah baik bang. Ada apa bang?"},
    {"other": "Ada apa bang?"},
    {"user": "ga jadi"},
    {
      "other":
          "Ok bang semoga hari anda senin terus, Ok bang semoga hari anda senin terus"
    },
    {
      "other":
          "Ok bang semoga hari anda senin terus, Ok bang semoga hari anda senin terus, Ok bang semoga hari anda senin terus"
    },
    {"other": "Ok bang semoga hari anda senin terus"},
  ];

  @override
  void onInit() async {
    WidgetsBinding.instance.addObserver(this);
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isShowEmoji.value = false;
      }
    });
    mode = FlashMode.off;
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    cameraValue = await cameraController.initialize();
    assetList = await PickImage().loadAssets();
    update();
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    textEditingController.dispose();
    focusNode.dispose();
    cameraController.dispose();
    super.onClose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      try {
        isFlashOn.value = false;
        await cameraController.setFlashMode(FlashMode.off);
        if (cameraController.value.isInitialized) {
          await cameraController.pausePreview();
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    } else if (state == AppLifecycleState.resumed) {
      try {
        if (cameraController.value.isInitialized) {
          cameraController = CameraController(
              cameras[cameraPositioned.value], ResolutionPreset.max);
          cameraValue = await cameraController.initialize();
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    update();
  }

  Future<void> outOfCamera() async {
    try {
      isFlashOn.value = false;
      await cameraController.setFlashMode(FlashMode.off);
    } catch (e) {
      debugPrint(e.toString());
    }
    Get.back();
    update();
  }

  Future<void> takePicture() async {
    try {
      isTakingPicture.value = true;
      await cameraController.setFlashMode(mode);
      XFile file = await cameraController.takePicture();
      image = File(file.path);
      if (cameras[cameraPositioned.value].lensDirection ==
          CameraLensDirection.front) {
        img.Image imageFile = img.decodeImage(image!.readAsBytesSync())!;
        img.Image flippedImage =
            img.flip(imageFile, direction: img.FlipDirection.horizontal);

        File flippedFile = File(file.path)
          ..writeAsBytesSync(img.encodeJpg(flippedImage));
        image = flippedFile;
      }
      if (image != null) {
        textEditingController.text = image.toString();
        isTextFieldEmpty.value = false;
      }
      await outOfCamera();
      isTakingPicture.value = false;
    } catch (e) {
      debugPrint(e.toString());
    }
    update();
  }

  Future<void> onSetFlashModeButtonPressed() async {
    isFlashOn.toggle();
    if (isFlashOn.value) {
      mode = FlashMode.torch;
    } else {
      mode = FlashMode.off;
    }
    try {
      await cameraController.setFlashMode(mode);
    } catch (e) {
      debugPrint(e.toString());
    }
    update();
  }

  Future<void> swicthCamera() async {
    isFrontCamera.toggle();
    isFlashOn.value = false;
    if (isFrontCamera.value) {
      cameraPositioned.value = 0;
    } else {
      cameraPositioned.value = 1;
    }
    try {
      cameraController = CameraController(
          cameras[cameraPositioned.value], ResolutionPreset.max);
      cameraValue = await cameraController.initialize();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
    update();
  }

  void addImage(AssetEntity image) {
    if (selectedAssetList.contains(image)) {
      selectedAssetList.remove(image);
    } else {
      selectedAssetList.add(image);
    }
    update();
  }

  void sendImageGallery() {
    for (AssetEntity i in selectedAssetList) {
      chats.add({"user": i});
    }
    Get.forceAppUpdate();
    Get.back();
  }

  void sendChat() {
    if (textEditingController.text == image.toString()) {
      chats.add({"user": image});
    } else {
      chats.add({"user": textEditingController.text});
    }

    textEditingController.clear();
    isTextFieldEmpty.value = true;
    Get.forceAppUpdate();
  }

// cek apakah user yang mengirimkan chat?
  bool isUser(int index) {
    return chats[index].keys.first == "user";
  }

// function yang mengembalikan border radius yang
// lancip pada bagian kanan bawah pada chat user
  BorderRadius initialUserChatBorder() {
    return BorderRadius.only(
        topLeft: Radius.circular(defaultRadius.value),
        topRight: Radius.circular(defaultRadius.value),
        bottomLeft: Radius.circular(defaultRadius.value),
        bottomRight: Radius.circular(taperRadius.value));
  }

// function yang mengembalikan border radius yang
// lancip pada bagian kanan atas pada chat user
  BorderRadius finalUserChatBorder() {
    return BorderRadius.only(
        topLeft: Radius.circular(defaultRadius.value),
        bottomLeft: Radius.circular(defaultRadius.value),
        bottomRight: Radius.circular(defaultRadius.value),
        topRight: Radius.circular(taperRadius.value));
  }

// function yang mengembalikan border radius yang
// lancip pada bagian kiri bawah pada chat lawannya
  BorderRadius initialOtherChatBorder() {
    return BorderRadius.only(
        topLeft: Radius.circular(defaultRadius.value),
        topRight: Radius.circular(defaultRadius.value),
        bottomRight: Radius.circular(defaultRadius.value),
        bottomLeft: Radius.circular(taperRadius.value));
  }

// function yang mengembalikan border radius yang
// lancip pada bagian kanan bawah pada chat lawannya
  BorderRadius finalOtherChatBorder() {
    return BorderRadius.only(
        topRight: Radius.circular(defaultRadius.value),
        bottomLeft: Radius.circular(defaultRadius.value),
        bottomRight: Radius.circular(defaultRadius.value),
        topLeft: Radius.circular(taperRadius.value));
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
}
