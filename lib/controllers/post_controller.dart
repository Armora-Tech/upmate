import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:upmatev2/models/post_model.dart';

import '../repositories/auth.dart';
import '../repositories/post_repository.dart';
import '../routes/route_name.dart';
import 'gallery_controller.dart';
import 'home_controller.dart';
import 'start_controller.dart';
import '../utils/upload.dart';

class PostController extends GetxController {
  late TextEditingController description;
  late TextEditingController edtTagInterest;
  late FocusNode focusNode;
  final galleryController = Get.find<GalleryController>();
  final startController = Get.find<StartController>();
  final homeController = Get.find<HomeController>();
  RxBool isCover = false.obs;
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
    for (var asset in galleryController.selectedAssetList) {
      try {
        final response = await Upload().uploadImage(asset);
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

    PostModel postModel = PostModel(
        ref: FirebaseFirestore.instance.collection("posts").doc(),
        interests: selectedTags,
        postDescription: description.text,
        userRaw: Auth().getCurrentUserReference(),
        timestamp: DateTime.now(),
        bookmarks: [],
        likes: [],
        postPhoto: imgUrl,
        isCover: isCover.value);

    await postModel.initUsers();
    await PostRepository().addPost(postModel);
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
