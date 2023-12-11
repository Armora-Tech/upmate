import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:upmatev2/themes/app_color.dart';

class PickImage {
  PickImage({ImageCropper? imageCropper})
      : _imageCropper = imageCropper ?? ImageCropper();

  final ImageCropper _imageCropper;

  Future<CroppedFile?> crop(
      {required File file, CropStyle cropStyle = CropStyle.circle}) async {
    return await _imageCropper.cropImage(
      sourcePath: file.path,
      cropStyle: cropStyle,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: const Color.fromARGB(255, 10, 25, 37),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            activeControlsWidgetColor: AppColor.primaryColor,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
  }

  Future<List<AssetEntity>> loadAssets() async {
    final permission = await PhotoManager.requestPermissionExtend();
    List<AssetEntity> assets = [];

    if (permission.isAuth) {
      int pageCount = 100;
      bool hasNext = true;
      int page = 0;

      while (hasNext) {
        List<AssetEntity> assetsPaged = await PhotoManager.getAssetListPaged(
          page: page,
          pageCount: pageCount,
          type: RequestType.image,
        );

        if (assetsPaged.isEmpty) {
          hasNext = false;
        } else {
          assets.addAll(assetsPaged);
          page++;
        }
      }
    } else {
      PhotoManager.openSetting();
    }
    return assets;
  }
}
