import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:upmatev2/controllers/gallery_controller.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_font.dart';

import 'package:upmatev2/widgets/createPost/gallery_section.dart';
import '../../widgets/global/line.dart';
import '../../widgets/createPost/create_post_header.dart';

class CreatePostView extends StatelessWidget {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    final galleryController = Get.find<GalleryController>();
    return Scaffold(
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
                        const CreatePostHeader(),
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
                                        child: const Icon(Icons.arrow_back,
                                            size: 25, color: Colors.black),
                                      ),
                                      GetBuilder<GalleryController>(
                                          builder: (_) => GestureDetector(
                                                onTap: galleryController
                                                            .assetList
                                                            .isEmpty ||
                                                        galleryController
                                                            .selectedAssetList
                                                            .isEmpty
                                                    ? () {}
                                                    : () => Get.toNamed(
                                                        RouteName
                                                            .postDescription),
                                                child: Text(
                                                  "next".tr,
                                                  style: AppFont.text16.copyWith(
                                                      color: galleryController
                                                              .selectedAssetList
                                                              .isEmpty
                                                          ? Colors.grey
                                                          : Colors.blueAccent,
                                                      fontWeight:
                                                          FontWeight.w600),
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
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: const CreatePostGallery()),
      ),
    );
  }
}
