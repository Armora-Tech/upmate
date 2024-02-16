import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/home_controller.dart';
import 'package:upmatev2/models/post_model.dart';
import 'package:upmatev2/repositories/utils_repository.dart';
import 'package:upmatev2/widgets/global/snack_bar.dart';
import '../models/comment_model.dart';
import '../repositories/post_repository.dart';
import 'start_controller.dart';

class PostDetailController extends GetxController {
  late FocusNode focusNode;
  // the name should be textEditingController for the needs of the emoji section
  late final TextEditingController textEditingController;
  PostModel? post;
  late final int postIndex;
  late final HomeController _homeController;
  late final StartController _startController;
  RxInt selectedIndex = 0.obs;
  RxInt i = 0.obs;
  RxBool isTextFieldEmpty = true.obs;
  RxBool isShowEmoji = false.obs;
  RxBool isDeleting = false.obs;
  RxBool isLoading = false.obs;
  RxBool isSendingComment = false.obs;

  @override
  Future<void> onInit() async {
    textEditingController = TextEditingController();
    _homeController = Get.find<HomeController>();
    _startController = Get.find<StartController>();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isShowEmoji.value = false;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    post!.selectedDotsIndicator = _homeController.oldSelectedImage.value;
    _homeController.update();
    textEditingController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  Future<void> addComment(PostModel post) async {
    isSendingComment.value = true;
    final String comment =
        await UtilsRepository().censorWords(textEditingController.text.trim());
    final commentModel = CommentModel(
      ref: FirebaseFirestore.instance.collection("comments").doc(),
      date: DateTime.now(),
      postRef: post.ref,
      text: comment,
      userRef: _startController.user!.ref,
    );
    await PostRepository().addComment(commentModel);
    textEditingController.clear();
    isTextFieldEmpty.value = true;
    update();
    await post.getComment();
    Get.forceAppUpdate();
    await Future.delayed(const Duration(seconds: 2));
    isSendingComment.value = false;
    update();
  }

  Future<void> deletePost(PostModel post) async {
    isDeleting.value = true;
    try {
      await PostRepository().deletePost(post.ref.path);
      await _homeController.refreshPosts();
      await _startController.refreshStart();
      Get.back();
      SnackBarWidget.showSnackBar(true, "successfully_deleted_the_post".tr);
    } catch (e) {
      SnackBarWidget.showSnackBar(false, "failed_to_delete_post".tr);
      debugPrint(e.toString());
    }
    isDeleting.value = false;
    Get.forceAppUpdate();
  }
}
