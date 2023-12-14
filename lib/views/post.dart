import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:upmatev2/controllers/gallery_controller.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/themes/app_font.dart';
import 'package:upmatev2/views/camera_view.dart';
import 'package:upmatev2/widgets/global/scroll_up.dart';
import 'package:upmatev2/widgets/global/skelton.dart';
import '../widgets/global/line.dart';

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    final galleryController = Get.find<GalleryController>();
    return GetBuilder<GalleryController>(
        builder: (_) => Scaffold(
              body: SafeArea(
                child: NestedScrollView(
                  controller: galleryController.scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.white,
                        expandedHeight: Get.width + 52,
                        floating: false,
                        pinned: false,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 51.8,
                                  ),
                                  galleryController.assetList.isEmpty
                                      ? ShimmerSkelton(
                                          height: Get.width,
                                          width: Get.width,
                                          borderRadius: 0,
                                        )
                                      : Container(
                                          color: const Color.fromARGB(
                                              255, 18, 18, 18),
                                          height: Get.width,
                                          width: Get.width,
                                          child: galleryController
                                                  .selectedAssetList.isEmpty
                                              ? const Center(
                                                  child: Text(
                                                    "Tidak ada gambar",
                                                    style: TextStyle(
                                                        color:
                                                            AppColor.lightGrey),
                                                  ),
                                                )
                                              : Stack(
                                                  children: [
                                                    CarouselSlider(
                                                      options: CarouselOptions(
                                                        viewportFraction: 1,
                                                        aspectRatio: 1,
                                                        enlargeCenterPage:
                                                            false,
                                                        enableInfiniteScroll:
                                                            false,
                                                        onPageChanged:
                                                            (index, reason) {
                                                          galleryController
                                                              .selectedIndex
                                                              .value = index;
                                                        },
                                                      ),
                                                      items: galleryController
                                                          .selectedAssetList
                                                          .map<Widget>((image) {
                                                        return SizedBox(
                                                          width: Get.width,
                                                          child:
                                                              AssetEntityImage(
                                                            image,
                                                            isOriginal: true,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ),
                                                    galleryController
                                                            .selectedAssetList
                                                            .isEmpty
                                                        ? const SizedBox()
                                                        : Obx(() {
                                                            return Positioned(
                                                                top: 10,
                                                                right: 10,
                                                                child:
                                                                    Container(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          20,
                                                                      vertical:
                                                                          5),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30)),
                                                                  child: Text(
                                                                      "${galleryController.selectedIndex.value + 1}/${galleryController.selectedAssetList.length}"),
                                                                ));
                                                          })
                                                  ],
                                                ),
                                        )
                                ],
                              ),
                              Positioned(
                                top: 0,
                                child: Container(
                                  color: Colors.white,
                                  width: Get.width,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 13),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () => Get.back(),
                                              child: const Icon(
                                                Icons.arrow_back,
                                                size: 25,
                                                color: Colors.black,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: galleryController
                                                          .assetList.isEmpty ||
                                                      galleryController
                                                          .selectedAssetList
                                                          .isEmpty
                                                  ? () {}
                                                  : () => Get.toNamed(RouteName
                                                      .postDescription),
                                              child: Text(
                                                "Next",
                                                style: AppFont.text16
                                                    .copyWith(
                                                        color: galleryController
                                                                .selectedAssetList
                                                                .isEmpty
                                                            ? Colors.grey
                                                            : Colors.blueAccent,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Line()
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                  body: Stack(
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
                                          routeName: RouteName.confirmPostImage,
                                        )),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  elevation: 0,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: const BorderSide(
                                          width: 0.5,
                                          color: AppColor.lightGrey)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.camera_alt_rounded,
                                        size: 23, color: AppColor.black),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Ambil Gambar",
                                      style: AppFont.text14
                                          .copyWith(color: AppColor.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              itemCount: galleryController.assetList.isEmpty
                                  ? 50
                                  : galleryController.assetList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 2,
                              ),
                              itemBuilder: (context, index) {
                                final double size = Get.width / 4;
                                return galleryController.assetList.isEmpty
                                    ? ShimmerSkelton(
                                        height: size,
                                        width: size,
                                        borderRadius: 0,
                                      )
                                    : GestureDetector(
                                        onTap: () => galleryController
                                            .addPostImage(galleryController
                                                .assetList[index]),
                                        child: Container(
                                          height: size,
                                          width: size,
                                          color: AppColor.greyShimmer,
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              AssetEntityImage(
                                                galleryController
                                                    .assetList[index],
                                                isOriginal: false,
                                                thumbnailSize:
                                                    const ThumbnailSize.square(
                                                        250),
                                                fit: BoxFit.cover,
                                              ),
                                              galleryController
                                                      .assetList.isEmpty
                                                  ? const SizedBox()
                                                  : galleryController
                                                          .selectedAssetList
                                                          .contains(
                                                              galleryController
                                                                      .assetList[
                                                                  index])
                                                      ? Positioned(
                                                          top: 5,
                                                          right: 5,
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
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
                                                              size: 23,
                                                            ),
                                                          ))
                                                      : const SizedBox()
                                            ],
                                          ),
                                        ),
                                      );
                              },
                            ),
                          )
                        ],
                      ),
                      ScrollUp(controller: galleryController)
                    ],
                  ),
                ),
              ),
            ));
  }
}
