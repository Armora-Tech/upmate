import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart';
import '../main.dart';
import '../routes/route_name.dart';
import '../utils/pick_image.dart';

class CameraViewController extends GetxController with WidgetsBindingObserver {
  late CameraController cameraController;
  late void cameraValue;
  late FlashMode mode;
  File? image;
  RxBool isFlashOn = false.obs;
  RxBool isFrontCamera = true.obs;
  RxBool isTakingPicture = false.obs;
  RxInt cameraPositioned = 0.obs;

  @override
  void onInit() async {
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Color.fromARGB(255, 15, 22, 25),
      ),
    );
    mode = FlashMode.off;
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    cameraValue = await cameraController.initialize();
    update();
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
      ),
    );
    cameraController.dispose();
    update();
    super.onClose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      try {
        if (cameraController.value.isInitialized) {
          mode = FlashMode.off;
          await cameraController.setFlashMode(mode);
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
          await cameraController.resumePreview();
          isFlashOn.value = false;
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

  Future<void> takePictureWithCrop() async {
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
        final imagePicker = PickImage();
        final croppedImage =
            await imagePicker.crop(file: image!, cropStyle: CropStyle.circle);
        if (croppedImage != null) {
          image = File(croppedImage.path);
          isFlashOn.value = false;
          await cameraController.setFlashMode(FlashMode.off);
          isTakingPicture.value = false;
          Get.until(
            (route) => Get.previousRoute == RouteName.editProfile,
          );
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    Get.forceAppUpdate();
  }

  Future<void> takePicture(String routeName) async {
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
      isFlashOn.value = false;
      await cameraController.setFlashMode(FlashMode.off);
      Get.toNamed(routeName);
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
    }
    Get.forceAppUpdate();
  }

  void sendImageCamera(List<Map<String, dynamic>> chats) {
    chats.add({"user": image});
    Get.until((route) => Get.previousRoute == RouteName.chatRoom);
    Get.forceAppUpdate();
  }
}
