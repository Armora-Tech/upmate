import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:upmatev2/controllers/gallery_controller.dart';

import '../../controllers/camera_controller.dart';
import '../../themes/app_color.dart';
import '../../themes/app_font.dart';
import '../../pages/camera_page.dart';
import '../global/scroll_up.dart';
import '../global/skelton.dart';

class CreatePostGallery extends StatelessWidget {
  const CreatePostGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final galleryController = Get.find<GalleryController>();
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.center,
              child: IntrinsicWidth(
                child: ElevatedButton(
                  onPressed: galleryController.assetList.isEmpty
                      ? () {}
                      : () => Get.to(() => const CameraView(
                            page: CameraPage.post,
                          )),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    elevation: 0,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(
                          width: 0.5, color: AppColor.lightGrey),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.camera_alt_rounded,
                          size: 23, color: AppColor.black),
                      const SizedBox(width: 10),
                      Text("take_a_picture".tr, style: AppFont.text14),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GetBuilder<GalleryController>(
                builder: (_) => GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  itemCount: galleryController.assetList.isEmpty
                      ? 50
                      : galleryController.assetList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    final double size = Get.width / 4;
                    return galleryController.assetList.isEmpty
                        ? ShimmerSkelton(
                            height: size, width: size, borderRadius: 0)
                        : GestureDetector(
                            onTap: () => galleryController.addPostImage(
                                galleryController.assetList[index]),
                            child: Container(
                              height: size,
                              width: size,
                              color: AppColor.greyShimmer,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  AssetEntityImage(
                                      galleryController.assetList[index],
                                      isOriginal: false,
                                      thumbnailSize:
                                          const ThumbnailSize.square(250),
                                      fit: BoxFit.cover),
                                  galleryController.assetList.isEmpty
                                      ? const SizedBox()
                                      : galleryController.selectedAssetList
                                              .contains(galleryController
                                                  .assetList[index])
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
                                                    size: 23),
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
            )
          ],
        ),
        ScrollUp(controller: galleryController)
      ],
    );
  }
}
