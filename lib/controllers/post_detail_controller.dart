import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/home_controller.dart';
import 'package:upmatev2/models/post_model.dart';
import 'package:upmatev2/widgets/global/snack_bar.dart';
import '../repositories/post_repository.dart';
import 'start_controller.dart';

class PostDetailController extends GetxController {
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  late final PostModel post;
  late final HomeController _homeController;
  late final StartController _startController;
  RxInt selectedIndex = 0.obs;
  RxBool isTextFieldEmpty = true.obs;
  RxBool isShowEmoji = false.obs;
  RxBool isDeleting = false.obs;

  @override
  void onInit() {
    _homeController = Get.find<HomeController>();
    _startController = Get.find<StartController>();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isShowEmoji.value = false;
      }
    });
    post = Get.arguments;
    post.selectedDotsIndicator = 0;
    super.onInit();
  }

  @override
  void onClose() {
    post.selectedDotsIndicator = _homeController.oldSelectedImage.value;
    _homeController.update();
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
