import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/repositories/auth.dart';

import '../models/post_model.dart';
import '../models/user_model.dart';

class StartController extends GetxController {
  final Auth _auth = Auth();
  UserModel? user;
  RxBool isLoading = false.obs;
  List<PostModel>? myPosts = [];

  @override
  void onInit() async {
    await _getUser();
    await user!.getPosts();
    myPosts = user!.posts;
    for (int i = 0; i < myPosts!.length; i++) {
    debugPrint("waah $i : ${myPosts![i].comments}");
    debugPrint("waah foto $i : ${myPosts![i].postPhoto}");
    debugPrint("waah $i : ${myPosts![i].interests}");
    debugPrint("waah $i : ${myPosts![i].postDescription}");
    }
    super.onInit();
  }

  Future<void> _getUser() async {
    user = await _auth.getUserModel();
    update();
  }

  Future<void> refreshStart() async {
    isLoading.value = true;
    await _getUser();
    isLoading.value = false;
    update();
  }
}
