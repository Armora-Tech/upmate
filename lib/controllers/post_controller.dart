import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:upmatev2/models/post_model.dart';

import '../repositories/post_repository.dart';
import '../utils/auth.dart';
import 'start_controller.dart';

class PostController extends GetxController {
  late TextEditingController description;
  late FocusNode focusNode;
  final startController = Get.find<StartController>();
  RxBool isCover = false.obs;
  List<File>? images;
  List<String> selectedTags = [];
  
  List<String> tags = [
    "Data Science",
    "Statistika",
    "Machine Learning",
    "Programming",
    "Kalkulus",
    "Aljabar Linier",
    "Sistem digital",
    "Matematika",
    "Akuntan",
    "Fisika",
    "Robotik"
  ];

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
    PostModel postModel = PostModel(
        ref: FirebaseFirestore.instance.collection("posts").doc(),
        interests: selectedTags,
        postDescription: description.text,
        postTitle: startController.user!.username + DateTime.now().toString(),
        userRaw: Auth().getCurrentUserReference(),
        timestamp: DateTime.now(),
        bookmarks: [],
        likes: [],
        postPhoto: images![0].toString(),
        isCover: isCover.value);
    await PostRepository().addPost(postModel);
  }

  Future<void> deletePost(String docRefID) async {
    await PostRepository().deletePost(docRefID);
  }

  void toggleInterest(int index) {
    if (selectedTags.contains(tags[index])) {
      selectedTags.remove(tags[index]);
    } else {
      selectedTags.add(tags[index]);
    }
    update();
  }
}
