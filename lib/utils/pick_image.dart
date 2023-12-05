import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:upmatev2/themes/app_color.dart';

class PickImage {
  PickImage({ImagePicker? imagePicker, ImageCropper? imageCropper})
      : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();

  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  Future<List<XFile>> pickMedia(
      {ImageSource source = ImageSource.camera,
      int imageQuality = 100,
      bool isMultiple = true}) async {
    source = source;
    if (!isMultiple) {
      return await _imagePicker.pickMultiImage(imageQuality: imageQuality);
    }
    final file = await _imagePicker.pickImage(
        source: source, imageQuality: imageQuality);

    if (file != null) return [file];
    return [];
  }

  Future<CroppedFile?> crop(
      {required XFile file, CropStyle cropStyle = CropStyle.rectangle}) async {
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
