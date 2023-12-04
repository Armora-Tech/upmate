import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upmatev2/themes/app_color.dart';

class PickImage {
  PickImage(
      {ImagePicker? imagePicker,
      ImageCropper? imageCropper,
      required this.isGallery})
      : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();
  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;
  bool isGallery = true;

  Future<List<XFile>> pickMedia(
      {ImageSource source = ImageSource.gallery,
      int imageQuality = 100,
      bool isMultiple = true}) async {
    source = isGallery ? ImageSource.gallery : ImageSource.camera;
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
}
