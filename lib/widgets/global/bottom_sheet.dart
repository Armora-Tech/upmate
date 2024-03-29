import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:upmatev2/controllers/camera_controller.dart';
import 'package:upmatev2/controllers/chat_room_controller.dart';
import 'package:upmatev2/controllers/edit_profile_controller.dart';
import 'package:upmatev2/controllers/gallery_controller.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/themes/app_font.dart';
import 'package:upmatev2/pages/camera_page.dart';
import 'package:upmatev2/widgets/global/line.dart';
import 'package:upmatev2/widgets/global/scroll_up.dart';
import 'package:upmatev2/widgets/global/skelton.dart';

import '../../controllers/observer/scroll_up_controller.dart';

class BottomSheetWidget {
  static void showGalleryChat(
      GalleryController controller, ChatRoomController chatRoomController) {
    final scrollUpController = Get.find<ScrollUpController>();
    Get.bottomSheet(
      isScrollControlled: true,
      Container(
        width: Get.width,
        height: Get.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        height: 4,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColor.primaryColor),
                      ),
                      const SizedBox(height: 10),
                      Text("select_from_gallery".tr,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                GetBuilder<GalleryController>(
                  builder: (_) => controller.assetList.isEmpty
                      ? const SizedBox()
                      : Container(
                          margin: const EdgeInsets.only(left: 10),
                          constraints: const BoxConstraints(maxWidth: 150),
                          child: IntrinsicWidth(
                            child: DropdownButton(
                              isExpanded: true,
                              value: controller.selectedAlbum,
                              onChanged: (value) async =>
                                  await controller.selectAlbum(value!),
                              items: controller.albumList.map(
                                (album) {
                                  return DropdownMenuItem(
                                    value: album,
                                    child: Text(
                                      album.name,
                                      style: AppFont.text14
                                          .copyWith(color: Colors.black),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ),
                ),
                Expanded(
                  child: GetBuilder<GalleryController>(
                    builder: (_) => GridView.builder(
                      controller: controller.scrollController,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      itemCount: controller.assetList.isEmpty ||
                              controller.isLoading.value
                          ? 51
                          : controller.assetList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemBuilder: (context, index) {
                        final double size = Get.width / 3;
                        return controller.assetList.isEmpty ||
                                controller.isLoading.value
                            ? ShimmerSkelton(
                                height: size, width: size, borderRadius: 0)
                            : GestureDetector(
                                onTap: () {
                                  controller
                                      .addImage(controller.assetList[index]);
                                  scrollUpController.update();
                                },
                                child: Container(
                                  height: size,
                                  width: size,
                                  color: AppColor.greyShimmer,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      AssetEntityImage(
                                        controller.assetList[index],
                                        isOriginal: false,
                                        filterQuality: FilterQuality.medium,
                                        thumbnailSize:
                                            const ThumbnailSize.square(250),
                                        fit: BoxFit.cover,
                                      ),
                                      controller.selectedAssetList.contains(
                                              controller.assetList[index])
                                          ? Positioned(
                                              top: 5,
                                              right: 5,
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle),
                                                child: const Icon(
                                                    Icons.check_circle_rounded,
                                                    color: Colors.blueAccent,
                                                    size: 25),
                                              ),
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                ),
                              );
                      },
                    ),
                  ),
                ),
              ],
            ),
            GetBuilder<ScrollUpController>(
              builder: (_) => AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                bottom: controller.selectedAssetList.isEmpty &&
                        !controller.isBtnShown.value
                    ? 15
                    : -50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    Get.back();
                    Get.to(() => const CameraView(page: CameraPage.chat),
                        transition: Transition.rightToLeft);
                  },
                  child: IntrinsicWidth(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          const Icon(Icons.camera_alt_rounded,
                              color: Colors.white, size: 23),
                          const SizedBox(width: 10),
                          Text(
                            "take_a_picture".tr,
                            style: AppFont.text16.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GetBuilder<ScrollUpController>(
              builder: (_) => AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                bottom: controller.selectedAssetList.isEmpty ||
                        controller.isBtnShown.value
                    ? -50
                    : 15,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () => chatRoomController.sendImageFromGallery(),
                  child: IntrinsicWidth(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: GetBuilder<GalleryController>(
                        builder: (_) => Text(
                          "${"send".tr} "
                          "(${controller.selectedAssetList.length})",
                          style: AppFont.text16.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ScrollUp(controller: controller)
          ],
        ),
      ),
    );
  }

  static void showChooseImage(
      EditProfileController controller, bool isEditBanner) {
    Get.bottomSheet(
      IntrinsicHeight(
        child: Container(
          width: Get.width,
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  controller.isEditBanner.value = isEditBanner;
                  Get.to(
                    () => const CameraView(page: CameraPage.profile),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  color: Colors.white,
                  height: 45,
                  width: Get.width,
                  child: Center(
                    child: Text(
                      "take_a_picture".tr,
                      style: AppFont.text16.copyWith(color: Colors.blueAccent),
                    ),
                  ),
                ),
              ),
              const Line(),
              GestureDetector(
                onTap: () {
                  controller.isEditBanner.value = isEditBanner;
                  Get.toNamed(RouteName.galleryView);
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  color: Colors.white,
                  height: 45,
                  width: Get.width,
                  child: Center(
                    child: Text(
                      "select_from_gallery".tr,
                      style: AppFont.text16.copyWith(color: Colors.blueAccent),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
