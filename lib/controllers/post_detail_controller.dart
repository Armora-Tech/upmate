import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/home_controller.dart';
import 'package:upmatev2/controllers/profile_controller.dart';
import 'package:upmatev2/models/post_model.dart';
import 'package:upmatev2/widgets/global/snack_bar.dart';
import '../repositories/post_repository.dart';

class PostDetailController extends GetxController {
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  late final HomeController _homeController;
  late final ProfileController _profileController;
  RxInt selectedIndex = 0.obs;
  RxBool isTextFieldEmpty = true.obs;
  RxBool isShowEmoji = false.obs;
  RxBool isDeleting = false.obs;
  late final PostModel post;

  @override
  void onInit() {
    _homeController = Get.find<HomeController>();
    _profileController = Get.find<ProfileController>();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isShowEmoji.value = false;
      }
    });
    _homeController.selectedImage = 0.obs;
    post = Get.arguments;
    super.onInit();
  }

  @override
  void onClose() {
    _homeController.selectedImage.value = _homeController.oldSelectedImage.value;
    textEditingController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  Future<void> deletePost(PostModel post) async {
    isDeleting.value = true;
    debugPrint(" post id : ${post.ref.id}");
    try {
      await PostRepository().deletePost(post.ref.path);
      await _homeController.refreshPosts();
      _profileController.refreshMyPosts();
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
