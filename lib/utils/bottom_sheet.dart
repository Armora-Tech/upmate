import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:upmatev2/controllers/chat_room_controller.dart';
import 'package:upmatev2/controllers/edit_profile_controller.dart';
import 'package:upmatev2/controllers/gallery_controller.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/themes/app_font.dart';
import 'package:upmatev2/views/camera_view.dart';
import 'package:upmatev2/widgets/global/line.dart';
import 'package:upmatev2/widgets/global/scroll_up.dart';
import 'package:upmatev2/widgets/global/skelton.dart';

class BottomSheetUtil {
  static void showGalleryChat(
      GalleryController controller, ChatRoomController chatController) {
    Get.bottomSheet(
        isScrollControlled: true,
        GetBuilder<GalleryController>(
          builder: (_) => Container(
              width: Get.width,
              height: Get.height * 0.85,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Stack(alignment: Alignment.center, children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 4,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColor.primaryColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Pilih dari gallery",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GetBuilder<GalleryController>(
                        builder: (_) => Expanded(
                              child: GridView.builder(
                                controller: controller.scrollController,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                itemCount: controller.assetList.isEmpty
                                    ? 50
                                    : controller.assetList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2,
                                ),
                                itemBuilder: (context, index) {
                                  final double size = Get.width / 3;
                                  return controller.assetList.isEmpty
                                      ? ShimmerSkelton(
                                          height: size,
                                          width: size,
                                          borderRadius: 0,
                                        )
                                      : GestureDetector(
                                          onTap: () => controller.addImage(
                                              controller.assetList[index]),
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
                                                  thumbnailSize:
                                                      const ThumbnailSize
                                                          .square(250),
                                                  fit: BoxFit.cover,
                                                ),
                                                controller.selectedAssetList
                                                        .contains(controller
                                                            .assetList[index])
                                                    ? Positioned(
                                                        top: 5,
                                                        right: 5,
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  shape: BoxShape
                                                                      .circle),
                                                          child: const Icon(
                                                            Icons
                                                                .check_circle_rounded,
                                                            color: Colors
                                                                .blueAccent,
                                                            size: 25,
                                                          ),
                                                        ))
                                                    : const SizedBox()
                                              ],
                                            ),
                                          ),
                                        );
                                },
                              ),
                            ))
                  ],
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  bottom: controller.selectedAssetList.isEmpty &&
                          !controller.isBtnShown.value
                      ? 15
                      : -50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onPressed: () {
                        Get.back();
                        Get.to(
                            () => const CameraView(
                                routeName: RouteName.confirmSendImage),
                            transition: Transition.rightToLeft);
                      },
                      child: IntrinsicWidth(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                                size: 23,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Ambil Gambar",
                                style: AppFont.text16
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
                AnimatedPositioned(
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
                      onPressed: () =>
                          controller.sendImageGallery(chatController.chats),
                      child: IntrinsicWidth(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "Kirim(${controller.selectedAssetList.length})",
                            style: AppFont.text16
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      )),
                ),
                ScrollUp(
                  controller: controller,
                )
              ])),
        ));
  }

  static void showChooseImage(EditProfileController controller) {
    Get.bottomSheet(IntrinsicHeight(
      child: Container(
          width: Get.width,
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => Get.to(() => const CameraView(
                      isCrop: true,
                    )),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  color: Colors.white,
                  height: 45,
                  width: Get.width,
                  child: Center(
                    child: Text(
                      "Ambil gambar",
                      style: AppFont.text16
                          .copyWith(color: Colors.blueAccent),
                    ),
                  ),
                ),
              ),
              const Line(),
              GestureDetector(
                onTap: () => Get.toNamed(RouteName.galleryView),
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  color: Colors.white,
                  height: 45,
                  width: Get.width,
                  child: Center(
                    child: Text(
                      "Pilih dari gallery",
                      style: AppFont.text16
                          .copyWith(color: Colors.blueAccent),
                    ),
                  ),
                ),
              ),
            ],
          )),
    ));
  }
}
