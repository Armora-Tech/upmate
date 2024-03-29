import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:upmatev2/themes/app_color.dart';

class PickImage {
  PickImage({ImageCropper? imageCropper})
      : _imageCropper = imageCropper ?? ImageCropper();

  final ImageCropper _imageCropper;

  Future<CroppedFile?> crop(
      {required File file,
      CropStyle cropStyle = CropStyle.circle,
      bool isBanner = false}) async {
    return await _imageCropper.cropImage(
      sourcePath: file.path,
      cropStyle: cropStyle,
      compressQuality: 50,
      aspectRatioPresets: isBanner
          ? [CropAspectRatioPreset.ratio16x9]
          : [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: const Color.fromARGB(255, 10, 25, 37),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: isBanner
              ? CropAspectRatioPreset.ratio16x9
              : CropAspectRatioPreset.original,
          activeControlsWidgetColor: AppColor.primaryColor,
          lockAspectRatio: isBanner ? true : false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
  }

  Future<CroppedFile?> cropFromCameraPost(
      {required File file, isCover = true}) async {
    return await _imageCropper.cropImage(
      sourcePath: file.path,
      cropStyle: CropStyle.rectangle,
      compressQuality: 50,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: const Color.fromARGB(255, 10, 25, 37),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          activeControlsWidgetColor: AppColor.primaryColor,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
  }

  Future<List<AssetPathEntity>> loadAlbums(PermissionState permission) async {
    List<AssetPathEntity> albumList = [];
    if (permission.isAuth) {
      albumList = await PhotoManager.getAssetPathList(type: RequestType.image);
    } else {
      await PhotoManager.openSetting();
      permission = await PhotoManager.requestPermissionExtend();
      if (permission.isAuth) {
        albumList =
            await PhotoManager.getAssetPathList(type: RequestType.image);
      }
    }

    return albumList;
  }

  Future<List<AssetEntity>> loadAssets(AssetPathEntity selectedAlbum) async {
    List<AssetEntity> assetList = await selectedAlbum.getAssetListRange(
        start: 0, end: await selectedAlbum.assetCountAsync);

    return assetList;
  }

  Future<Uint8List?> compressImage(Uint8List file) async {
    try {
      final Uint8List compressedFile =
          await FlutterImageCompress.compressWithList(
        file,
        quality: 25,
      );
      return compressedFile;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
