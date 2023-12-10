import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:upmatev2/controllers/gallery_controller.dart';

import '../widgets/global/line.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GalleryController>();
    return Scaffold(
      body: Stack(
        children: [
          Expanded(
            child: GridView.builder(
              controller: controller.scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              itemCount: controller.assetList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemBuilder: (context, index) {
                final double size = Get.width / 3;
                return GestureDetector(
                  onTap: () => controller.addImage(controller.assetList[index]),
                  child: Container(
                    height: size,
                    width: size,
                    color: Colors.grey,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        AssetEntityImage(
                          controller.assetList[index],
                          isOriginal: false,
                          thumbnailSize: const ThumbnailSize.square(250),
                          fit: BoxFit.cover,
                        ),
                        controller.selectedAssetList
                                .contains(controller.assetList[index])
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
          Positioned(
            top: 0,
            child: Container(
              color: Colors.white,
              width: Get.width,
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 13),
                      child: Row(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Gallery",
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.more_vert_rounded,
                                size: 28,
                                color: Colors.black,
                              )
                            ],
                          ),
                          GestureDetector(
                              onTap: () {},
                              child: const SizedBox(
                                width: 50,
                                child: Text(
                                  "Simpan",
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                  ),
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
        ],
      ),
    );
  }
}
