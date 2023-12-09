import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import '../main.dart';
import '../utils/pick_image.dart';
import 'package:image/image.dart' as img;

class PostController extends GetxController with WidgetsBindingObserver {
  late final ScrollController scrollController;
  late CameraController cameraController;
  late void cameraValue;
  late FlashMode mode;
  AssetEntity? selectedEntity;
  List<AssetEntity> assetList = [];
  List<AssetEntity> selectedAssetList = [];
  RxInt selectedIndex = 0.obs;
  RxInt oldSelectedIndex = 0.obs;
  RxInt cameraPositioned = 0.obs;
  RxBool isBtnShown = false.obs;
  RxBool isFlashOn = false.obs;
  RxBool isFrontCamera = true.obs;
  RxBool isTakingPicture = false.obs;

  @override
  void onInit() async {
    WidgetsBinding.instance.addObserver(this);
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset > 0) {
        isBtnShown.value = true;
      } else {
        isBtnShown.value = false;
      }
      update();
    });
    mode = FlashMode.off;
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    cameraValue = await cameraController.initialize();
    assetList = await PickImage().loadAssets();
    selectedAssetList.add(assetList[0]);
    update();
    super.onInit();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    cameraController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      try {
        cameraValue = await cameraController.initialize();
        await cameraController.setFlashMode(FlashMode.off);
        isFlashOn.value = false;
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
      File image = File(file.path);
      if (cameras[cameraPositioned.value].lensDirection ==
          CameraLensDirection.front) {
        img.Image imageFile = img.decodeImage(image.readAsBytesSync())!;
        img.Image flippedImage =
            img.flip(imageFile, direction: img.FlipDirection.horizontal);

        File flippedFile = File(file.path)
          ..writeAsBytesSync(img.encodeJpg(flippedImage));
        image = flippedFile;
        final asset = await PhotoManager.editor.saveImage(
          utf8.encode(image.toString()),
          title: file.path,
        );
        if (asset != null) selectedAssetList.add(asset);
      }
      isFlashOn.value = false;
      await cameraController.setFlashMode(FlashMode.off);
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
    update();
  }

  void addImage(AssetEntity image) {
    if (selectedAssetList.length != 1 && selectedAssetList.contains(image)) {
      selectedAssetList.remove(image);
      if (selectedIndex.value > selectedAssetList.length - 1) {
        selectedIndex.value = selectedAssetList.length - 1;
      }
      if (selectedAssetList.length == 1) {
        selectedIndex.value = 0;
      }

      selectedIndex = oldSelectedIndex;
    } else if (!selectedAssetList.contains(image)) {
      selectedAssetList.add(image);
    }
    update();
  }
}
