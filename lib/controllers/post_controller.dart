import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:upmatev2/controllers/camera_controller.dart';
import 'package:upmatev2/models/post_model.dart';
import 'package:upmatev2/utils/pick_image.dart';

import '../repositories/auth.dart';
import '../repositories/post_repository.dart';
import '../routes/route_name.dart';
import 'gallery_controller.dart';
import 'start_controller.dart';
import '../utils/upload.dart';

class PostController extends GetxController {
  late final TextEditingController description;
  late final TextEditingController edtTagInterest;
  late final FocusNode focusNode;
  late final GalleryController _galleryController;
  late final StartController _startController;
  late final CameraViewController _cameraViewController;
  RxBool isCover = true.obs;
  RxBool isLoading = false.obs;
  RxBool isEmptyText = true.obs;
  List<File>? images;
  List<String> selectedTags = [];

  Map<String, String> tags = {
    "math".tr: "math",
    "calculus".tr: "calculus",
    "algebra".tr: "algebra",
    "economy".tr: "economy",
    "statistics".tr: "statistics",
    "digital_system".tr: "digital system",
    "linear_algebra".tr: "linear algebra",
    "physics".tr: "physics",
    "robotic".tr: "robotic",
    "programming".tr: "programming",
    "accountant".tr: "accountant"
  };

  @override
  void onInit() {
    _galleryController = Get.find<GalleryController>();
    _startController = Get.find<StartController>();
    _cameraViewController = Get.find<CameraViewController>();
    focusNode = FocusNode();
    description = TextEditingController();
    edtTagInterest = TextEditingController();
    focusNode.addListener(() {});
    update();
    super.onInit();
  }

  @override
  void dispose() {
    focusNode.dispose();
    description.dispose();
    edtTagInterest.dispose();
    super.dispose();
  }

  Future<void> addPost() async {
    isLoading.value = true;
    List<String> imgUrl = [];
    if (_cameraViewController.image == null) {
      for (var asset in _galleryController.selectedAssetList) {
        try {
          File? assetData = await asset.loadFile();
          final Directory tempDir = await getTemporaryDirectory();
          File newAsset = File(
              "${tempDir.path}/IMG-${Auth().getCurrentUserReference().id}${DateTime.now()}");
          await newAsset.create();
          List<int> bytes = await assetData!.readAsBytes();

          final uint8List = Uint8List.fromList(bytes);
          final result = await PickImage().compressImage(uint8List);
          newAsset.writeAsBytesSync(result!);
          final response = await Upload().uploadImage(newAsset);
          if (response.statusCode == 200) {
            final responseData = response.body;
            final jsonResponse = jsonDecode(responseData);
            imgUrl.add(jsonResponse['url']);
          } else {
            //error
            return;
          }
        } catch (error) {
          return;
        }
      }
    } else {
      final imgUploaded =
          await Upload().uploadFromCamera(_cameraViewController);
      imgUrl.add(imgUploaded);
    }

    PostModel postModel = PostModel(
        ref: FirebaseFirestore.instance.collection("posts").doc(),
        interests: selectedTags,
        postDescription: description.text,
        userRaw: FirebaseAuth.instance.currentUser!.uid,
        timestamp: DateTime.now(),
        bookmarks: [],
        likes: [],
        comments: [],
        postPhoto: imgUrl,
        isCover: isCover.value);

    await postModel.initUsers();
    await PostRepository().addPost(postModel);
    await _startController.refreshStart();
    isLoading.value = false;
    Get.offAllNamed(RouteName.start);
    Get.forceAppUpdate();
  }

  void toggleInterest(int index) {
    if (selectedTags.contains(tags.values.elementAt(index))) {
      selectedTags.remove(tags.values.elementAt(index));
    } else {
      selectedTags.add(tags.values.elementAt(index));
    }
    update();
  }
}
