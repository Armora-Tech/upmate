import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:upmatev2/controllers/home_controller.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/repositories/auth.dart';
import 'package:upmatev2/repositories/user_repository.dart';

import '../routes/route_name.dart';
import '../utils/pick_image.dart';
import '../widgets/global/snack_bar.dart';

class GalleryController extends GetxController {
  late final ScrollController scrollController;
  late final StartController _startController;
  late final HomeController _homeController;
  RxBool isBtnShown = false.obs;
  RxBool isLoading = false.obs;
  RxInt selectedIndex = 0.obs;
  RxInt oldSelectedIndex = 0.obs;

  File? image;
  AssetEntity? selectedEntity;
  List<AssetEntity> assetList = [];
  List<AssetEntity> selectedAssetList = [];

  @override
  Future<void> onInit() async {
    scrollController = ScrollController();
    _startController = Get.find<StartController>();
    _homeController = Get.find<HomeController>();
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
    scrollController.removeListener(() {});
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
    if (selectedAssetList.isNotEmpty && selectedAssetList.contains(image)) {
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
        isLoading.value = true;
        Get.until((route) => Get.previousRoute == RouteName.editProfile);

        await UserRepository().updateProfile(image!);
        await _startController.refreshStart();
        await _homeController.refreshPosts();
        Get.forceAppUpdate();
        isLoading.value = false;
        SnackBarWidget.showSnackBar(
            true, "${"success".tr} ${"update_photo_profile".tr}");
      }
    }
  }

  Future<void> updateBanner() async {
    if (selectedEntity != null) {
      image = await selectedEntity!.file;
      final imagePicker = PickImage();
      final croppedImage = await imagePicker.crop(
          file: image!, cropStyle: CropStyle.rectangle, isBanner: true);
      if (croppedImage != null) {
        image = File(croppedImage.path);
        isLoading.value = true;
        Get.until((route) => Get.previousRoute == RouteName.editProfile);

        await UserRepository().updateBanner(image!);
        await _startController.refreshStart();
        Get.forceAppUpdate();
        isLoading.value = false;
        SnackBarWidget.showSnackBar(
            true, "${"success".tr} ${"update_banner".tr}");
      }
    }
  }
}
