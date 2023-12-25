import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:upmatev2/models/post_model.dart';
import '../repositories/post_repository.dart';
import '../repositories/auth.dart';
import '../routes/route_name.dart';
import 'gallery_controller.dart';
import 'start_controller.dart';

class PostController extends GetxController {
  late TextEditingController description;
  late FocusNode focusNode;
  final galleryController = Get.find<GalleryController>();
  final startController = Get.find<StartController>();
  RxBool isCover = false.obs;
  RxBool isLoading = false.obs;
  List<File>? images;
  List<String> selectedTags = [];

  Map<String, String> tags = {
    "math".tr: "math",
    "calculus".tr: "calculus",
    "algebra".tr: "algebra",
    "economy".tr: "economy",
    "statistics".tr: "statistics",
    "digital_system".tr: "digital_system",
    "linear_algebra".tr: "linear_algebra",
    "physics".tr: "physics",
    "robotic".tr: "robotic",
    "programming".tr: "programming",
    "accountant".tr: "accountant"
  };

  @override
  void onInit() {
    focusNode = FocusNode();
    description = TextEditingController();
    focusNode.addListener(() {});
    update();
    super.onInit();
  }

  @override
  void dispose() {
    focusNode.dispose();
    description.dispose();
    super.dispose();
  }

  Future<void> addPost() async {
    isLoading.value = true;
    final url = Uri.parse('https://armoratech.my.id/upmateimg/upload');
    List<String> imgUrl = [];
    for (var asset in galleryController.selectedAssetList) {
      final img = await asset.file;
      final Map<String, String> headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
      };
      final Map<String, String> body = {
        'ref': startController.user!.username + DateTime.now().toString(),
        'img': base64.encode(await img!.readAsBytes())
      };

      try {
        final response = await http.post(url, headers: headers, body: body);
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
    Get.offNamed(RouteName.start);
  }

  Future<void> deletePost(String docRefID) async {
    await PostRepository().deletePost(docRefID);
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
