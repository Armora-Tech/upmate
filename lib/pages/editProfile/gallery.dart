import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:upmatev2/controllers/edit_profile_controller.dart';
import 'package:upmatev2/controllers/gallery_controller.dart';
import 'package:upmatev2/themes/app_font.dart';
import 'package:upmatev2/widgets/global/scroll_up.dart';

import '../../themes/app_color.dart';
import '../../widgets/global/line.dart';
import '../../widgets/global/skelton.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GalleryController>();
    final editProfileController = Get.find<EditProfileController>();
    return GetBuilder<GalleryController>(
      builder: (_) => Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                const SizedBox(height: 90),
                Expanded(
                  child: GridView.builder(
                    controller: controller.scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    itemCount: controller.assetList.isEmpty
                        ? 30
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
                              onTap: () => controller.selectPhotoProfile(
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
                                          const ThumbnailSize.square(250),
                                      fit: BoxFit.cover,
                                    ),
                                    controller.selectedEntity ==
                                            controller.assetList[index]
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
                ),
              ],
            ),
            Positioned(
              top: 0,
              child: Container(
                color: Colors.white,
                width: Get.width,
                height: 90,
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Get.back(),
                                  child: const Icon(
                                    Icons.arrow_back,
                                    size: 26,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  "Gallery",
                                  style: AppFont.text20.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                                onTap: () async =>
                                    editProfileController.isEditBanner.value
                                        ? await controller.updateBanner()
                                        : await controller.updatePhotoProfile(),
                                child: Text(
                                  "save".tr,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.blueAccent,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      const Line()
                    ],
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
}
