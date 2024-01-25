import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:upmatev2/controllers/gallery_controller.dart';

import '../../controllers/post_controller.dart';
import '../../themes/app_color.dart';
import '../global/skelton.dart';

class CreatePostHeader extends StatelessWidget {
  const CreatePostHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final galleryController = Get.find<GalleryController>();
    final controller = Get.find<PostController>();
    return Column(
      children: [
        const SizedBox(
          height: 51.8,
        ),
        GetBuilder<GalleryController>(
          builder: (_) => galleryController.assetList.isEmpty
              ? ShimmerSkelton(
                  height: Get.width, width: Get.width, borderRadius: 0)
              : Container(
                  color: const Color.fromARGB(255, 18, 18, 18),
                  height: Get.width,
                  width: Get.width,
                  child: galleryController.selectedAssetList.isEmpty
                      ? Center(
                          child: Text("no_picture".tr,
                              style:
                                  const TextStyle(color: AppColor.lightGrey)),
                        )
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            GetBuilder<PostController>(
                              builder: (_) => CarouselSlider(
                                options: CarouselOptions(
                                  viewportFraction: 1,
                                  aspectRatio:
                                      controller.isCover.value ? 1 : 16 / 9,
                                  enlargeCenterPage: false,
                                  enableInfiniteScroll: false,
                                  onPageChanged: (index, reason) {
                                    galleryController.selectedIndex.value =
                                        index;
                                    controller.update();
                                    galleryController.update();
                                  },
                                ),
                                items: galleryController.selectedAssetList
                                    .map<Widget>(
                                  (image) {
                                    return GetBuilder<PostController>(
                                      builder: (_) => SizedBox(
                                        width: Get.width,
                                        child: AssetEntityImage(image,
                                            isOriginal: true,
                                            fit: BoxFit.cover),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                            galleryController.selectedAssetList.isEmpty
                                ? const SizedBox()
                                : Positioned(
                                    top: 10,
                                    right: 10,
                                    child: IconButton(
                                      onPressed: () => galleryController
                                          .removePostImage(galleryController
                                                  .selectedAssetList[
                                              galleryController
                                                  .selectedIndex.value]),
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                    ),
                                  ),
                            galleryController.selectedAssetList.isEmpty
                                ? const SizedBox()
                                : Positioned(
                                    top: 15,
                                    left: 15,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              153, 0, 0, 0),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Text(
                                        "${galleryController.selectedIndex.value + 1}/${galleryController.selectedAssetList.length}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                            Positioned(
                              bottom: 10,
                              left: 15,
                              child: GestureDetector(
                                onTap: () {
                                  controller.isCover.toggle();
                                  controller.update();
                                },
                                child: Transform.rotate(
                                  angle: -10,
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    padding: const EdgeInsets.only(left: 3),
                                    decoration: const BoxDecoration(
                                        color: Color.fromARGB(153, 0, 0, 0),
                                        shape: BoxShape.circle),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.arrow_back_ios,
                                            size: 13, color: Colors.white),
                                        Icon(Icons.arrow_forward_ios,
                                            size: 13, color: Colors.white),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                ),
        )
      ],
    );
  }
}
