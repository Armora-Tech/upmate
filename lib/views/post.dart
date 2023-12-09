import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:upmatev2/controllers/post_controller.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/widgets/global/skelton.dart';
import '../widgets/global/line.dart';

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PostController>();
    return GetBuilder<PostController>(
        builder: (_) => WillPopScope(
            onWillPop: () async {
              Get.back();
              return true;
            },
            child: Scaffold(
              body: SafeArea(
                child: NestedScrollView(
                  controller: controller.scrollController,
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
                                  controller.assetList.isEmpty
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
                                          child: Stack(
                                            children: [
                                              CarouselSlider(
                                                options: CarouselOptions(
                                                  viewportFraction: 1,
                                                  aspectRatio: 1,
                                                  enlargeCenterPage: false,
                                                  enableInfiniteScroll: false,
                                                  onPageChanged:
                                                      (index, reason) {
                                                    controller.selectedIndex
                                                        .value = index;
                                                  },
                                                ),
                                                items: controller
                                                    .selectedAssetList
                                                    .map<Widget>((image) {
                                                  return SizedBox(
                                                    width: Get.width,
                                                    child: AssetEntityImage(
                                                      image,
                                                      isOriginal: true,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                              Obx(() {
                                                controller.oldSelectedIndex =
                                                    controller.selectedIndex;
                                                return Positioned(
                                                    top: 10,
                                                    right: 10,
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20,
                                                          vertical: 5),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30)),
                                                      child: Text(
                                                          "${controller.selectedIndex.value + 1}/${controller.selectedAssetList.length}"),
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
                                            const Text(
                                              "Next",
                                              style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      width: 0.5, color: AppColor.lightGrey)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: const Icon(
                                      Icons.photo_library_outlined,
                                      size: 26,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: const Icon(
                                      Icons.photo_camera_outlined,
                                      size: 26,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: const Icon(
                                      Icons.edit_outlined,
                                      size: 26,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              itemCount: controller.assetList.isEmpty
                                  ? 50
                                  : controller.assetList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 2,
                              ),
                              itemBuilder: (context, index) {
                                final double size = Get.width / 4;
                                return GestureDetector(
                                  onTap: () => controller
                                      .addImage(controller.assetList[index]),
                                  child: Container(
                                    height: size,
                                    width: size,
                                    color: Colors.grey,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        controller.assetList.isEmpty
                                            ? ShimmerSkelton(
                                                height: size,
                                                width: size,
                                                borderRadius: 0,
                                              )
                                            : AssetEntityImage(
                                                controller.assetList[index],
                                                isOriginal: false,
                                                thumbnailSize:
                                                    const ThumbnailSize.square(
                                                        250),
                                                fit: BoxFit.cover,
                                              ),
                                        controller.assetList.isEmpty
                                            ? const SizedBox()
                                            : controller.selectedAssetList
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
                                                              color:
                                                                  Colors.white,
                                                              shape: BoxShape
                                                                  .circle),
                                                      child: const Icon(
                                                        Icons
                                                            .check_circle_rounded,
                                                        color:
                                                            Colors.blueAccent,
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
                      AnimatedPositioned(
                          duration: const Duration(milliseconds: 300),
                          bottom: controller.isBtnShown.value ? 20 : -35,
                          child: GestureDetector(
                            onTap: () => controller.scrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.easeInOut),
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: const BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: const Icon(
                                Icons.arrow_upward_rounded,
                                size: 26,
                                color: Colors.black,
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            )));
  }
}
