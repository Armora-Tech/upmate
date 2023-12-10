import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:upmatev2/controllers/edit_profile_controller.dart';

import '../routes/route_name.dart';
import '../utils/pick_image.dart';

class GalleryController extends GetxController {
  late ScrollController scrollController;
  late EditProfileController editProfileController;
  RxBool isBtnShown = false.obs;
  RxInt selectedIndex = 0.obs;
  RxInt oldSelectedIndex = 0.obs;

  AssetEntity? selectedEntity;
  List<AssetEntity> assetList = [];
  List<AssetEntity> selectedAssetList = [];

  @override
  Future<void> onInit() async {
    scrollController = ScrollController();
    editProfileController = Get.find<EditProfileController>();
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

  void selectPhotoProfile(AssetEntity image) {
    selectedEntity = image;
    debugPrint("$selectedEntity");
    update();
  }

  Future<void> updatePhotoProfile() async {
    if (selectedEntity != null) {
      editProfileController.image = await selectedEntity!.file;
      final imagePicker = PickImage();
      final croppedImage =
          await imagePicker.crop(file: editProfileController.image!, cropStyle: CropStyle.circle);
      if (croppedImage != null) {
        editProfileController.image = File(croppedImage.path);
        Get.until(
          (route) => Get.previousRoute == RouteName.editProfile,
        );
      }
    }
    Get.forceAppUpdate();
  }
}
