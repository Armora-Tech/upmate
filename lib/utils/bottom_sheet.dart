import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:upmatev2/controllers/chat_room_controller.dart';
import 'package:upmatev2/controllers/edit_profile_controller.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/widgets/global/camera_view.dart';

class BottomSheetUtil {
  static void showGalleryChat(ChatRoomController controller) {
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
                        controller: controller.scrollController,
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
                        Get.to(() => const CameraView(
                            routeName: RouteName.confirmSendImage));
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
                                "Ambil Gambar",
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
                  bottom: controller.selectedAssetList.isEmpty ||
                          controller.isBtnShown.value
                      ? -50
                      : 15,
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
                ),
                AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    bottom: controller.isBtnShown.value ? 15 : -50,
                    child: GestureDetector(
                      onTap: () => controller.scrollController.animateTo(0,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInOut),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: const Row(children: [
                          Text(
                            "Gulir ke atas",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_upward_rounded,
                            size: 20,
                            color: Colors.black,
                          ),
                        ]),
                      ),
                    ))
              ])),
        ));
  }

  static void showChooseImage(EditProfileController controller) {
    Get.bottomSheet(IntrinsicHeight(
      child: Container(
          width: Get.width,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    backgroundColor: Colors.white),
                onPressed: () {},
                child: const Center(
                  child: Text(
                    "Ambil gambar",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    backgroundColor: Colors.white),
                onPressed: () {},
                child: const Center(
                  child: Text(
                    "Pilih dari gallery",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                  ),
                ),
              ),
            ],
          )),
    ));
  }
}
