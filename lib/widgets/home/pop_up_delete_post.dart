import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/home_controller.dart';
import 'package:upmatev2/controllers/post_detail_controller.dart';
import 'package:upmatev2/models/post_model.dart';
import 'package:upmatev2/themes/app_font.dart';

class PopUpDeletePost {
  static final controller = Get.find<HomeController>();
  static final postDetailController = Get.find<PostDetailController>();
  static void showDialog(PostModel post, int index) {
    Get.defaultDialog(
      title: "are_you_sure_you_want_to_delete_this_post".tr,
      titleStyle: AppFont.text14.copyWith(
        color: Colors.white,
        overflow: TextOverflow.visible,
      ),
      titlePadding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      backgroundColor: Colors.black,
      contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      actions: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Text('cancel'.tr,
              style: AppFont.text14.copyWith(color: Colors.blueAccent)),
        ),
        const SizedBox(width: 80),
        GestureDetector(
          onTap: () {
            controller.deletePost(post, index);
            Get.back();
          },
          child: Text('delete'.tr,
              style: AppFont.text14.copyWith(color: Colors.redAccent)),
        ),
      ],
    );
  }

  static void showDialogFromPostDetail(PostModel post) {
    Get.defaultDialog(
      title: "are_you_sure_you_want_to_delete_this_post".tr,
      titleStyle: AppFont.text14
          .copyWith(color: Colors.white, overflow: TextOverflow.visible),
      titlePadding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      backgroundColor: Colors.black,
      contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      actions: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Text('cancel'.tr,
              style: AppFont.text14.copyWith(color: Colors.blueAccent)),
        ),
        const SizedBox(width: 80),
        GestureDetector(
          onTap: () {
            postDetailController.deletePost(post);
            Get.back();
          },
          child: Text('delete'.tr,
              style: AppFont.text14.copyWith(color: Colors.redAccent)),
        ),
      ],
    );
  }
}
