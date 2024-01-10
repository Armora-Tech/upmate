import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:upmatev2/models/user_model.dart';
import 'package:upmatev2/repositories/auth.dart';

import '../routes/route_name.dart';
import '../utils/pick_image.dart';

class GalleryController extends GetxController {
  late ScrollController scrollController;
  RxBool isBtnShown = false.obs;
  RxInt selectedIndex = 0.obs;
  RxInt oldSelectedIndex = 0.obs;

  File? image;
  AssetEntity? selectedEntity;
  List<AssetEntity> assetList = [];
  List<AssetEntity> selectedAssetList = [];

  @override
  Future<void> onInit() async {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
              ScrollDirection.forward ||
          scrollController.offset == 0) {
        isBtnShown.value = false;
      } else {
        isBtnShown.value = true;
      }
      update();
    });
    assetList = await PickImage().loadAssets();
    update();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void addImage(AssetEntity image) {
    if (selectedAssetList.contains(image)) {
      selectedAssetList.remove(image);
    } else {
      selectedAssetList.add(image);
    }
    print(selectedAssetList);
    update();
  }

  void sendImageGallery(List<Map<String, dynamic>> chats) {
    for (AssetEntity i in selectedAssetList) {
      chats.add({"user": i});
    }
    Get.forceAppUpdate();
    Get.back();
  }

  void addPostImage(AssetEntity image) {
    if (selectedAssetList.contains(image)) {
      selectedAssetList.remove(image);
      if (selectedIndex.value > selectedAssetList.length - 1 &&
          selectedAssetList.isNotEmpty) {
        selectedIndex.value = selectedAssetList.length - 1;
      }
    } else if (!selectedAssetList.contains(image)) {
      selectedAssetList.add(image);
    }
    update();
  }

  void removePostImage(AssetEntity image) {
    if (selectedAssetList.contains(image)) {
      selectedAssetList.remove(image);
      if (selectedIndex.value > selectedAssetList.length - 1 &&
          selectedAssetList.isNotEmpty) {
        selectedIndex.value = selectedAssetList.length - 1;
      }
    }
    update();
  }

  void selectPhotoProfile(AssetEntity image) {
    selectedEntity = image;
    debugPrint("$selectedEntity");
    update();
  }

  Future<void> updatePhotoProfile() async {
    if (selectedEntity != null) {
      image = await selectedEntity!.file;
      final imagePicker = PickImage();
      final croppedImage =
          await imagePicker.crop(file: image!, cropStyle: CropStyle.circle);
      if (croppedImage != null) {
        image = File(croppedImage.path);
        final user = await Auth().getUserModel();
        await user!.updateProfile(image!);
        Get.until((route) => Get.previousRoute == RouteName.editProfile);
      }
    }
    Get.forceAppUpdate();
  }
}
