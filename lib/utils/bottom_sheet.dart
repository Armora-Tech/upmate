import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:upmatev2/controllers/chat_room_controller.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/views/camera.dart';

class BottomSheetUtil {
  static void showBottomDialog(ChatRoomController controller) {
    Get.bottomSheet(
        isScrollControlled: true,
        GetBuilder<ChatRoomController>(
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
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        itemCount: controller.assetList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                        ),
                        itemBuilder: (context, index) {
                          final double size = Get.width / 3;
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
                                  AssetEntityImage(
                                    controller.assetList[index],
                                    isOriginal: false,
                                    thumbnailSize:
                                        const ThumbnailSize.square(250),
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
                    )
                  ],
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  bottom: controller.selectedAssetList.isEmpty ? 15 : -50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onPressed: () {
                        Get.back();
                        Get.to(() => const CameraView(),
                            transition: Transition.rightToLeft);
                      },
                      child: const IntrinsicWidth(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                                size: 23,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Ambil Foto",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  bottom: controller.selectedAssetList.isEmpty ? -50 : 15,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onPressed: () => controller.sendImageGallery(),
                      child: IntrinsicWidth(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "Kirim(${controller.selectedAssetList.length})",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                      )),
                )
              ])),
        ));
  }
}
