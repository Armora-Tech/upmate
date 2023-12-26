import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:upmatev2/controllers/post_controller.dart";
import "../../themes/app_font.dart";

class DialogInterest {
  static void showPopup(controller) {
    Get.defaultDialog(
      title: "your_tag_interest".tr,
      titleStyle: AppFont.text18.copyWith(
          color: Colors.black,
          fontFamily: "Nunito",
          fontWeight: FontWeight.bold),
      radius: 10,
      barrierDismissible: false,
      titlePadding: const EdgeInsets.only(top: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: Colors.white,
      content: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (text) {
                controller.isEmptyText.value = text.isEmpty;
                controller.update();
              },
              controller: controller.edtTagInterest,
              style: AppFont.text14,
              decoration: InputDecoration(
                  hintText: "# ${"type_your_interest".tr}",
                  hintStyle: AppFont.text14.copyWith(color: Colors.grey)),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: controller.isLoading.value
                        ? () {}
                        : () {
                            controller.edtTagInterest.clear();
                            Get.back();
                          },
                    child: Text(
                      "cancel".tr,
                      style: AppFont.text16.copyWith(color: Colors.redAccent),
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.isLoading.value ||
                            controller.isEmptyText.value
                        ? () {}
                        : () {
                            controller.tags[controller.edtTagInterest.text] =
                                controller.edtTagInterest.text;
                            controller.selectedTags
                                .add(controller.edtTagInterest.text);
                            controller.edtTagInterest.clear();
                            Get.back();
                            Get.forceAppUpdate();
                          },
                    child: Text(
                      "add".tr,
                      style: AppFont.text16.copyWith(
                          color: controller.isEmptyText.value
                              ? Colors.grey
                              : Colors.blueAccent,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
