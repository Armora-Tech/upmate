import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/edit_profile_controller.dart';
import 'package:upmatev2/controllers/gallery_controller.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/widgets/editProfile/app_bar.dart';
import 'package:upmatev2/widgets/global/blur_loading.dart';
import 'package:upmatev2/widgets/global/bottom_sheet.dart';
import 'package:upmatev2/widgets/editProfile/edit_page.dart';
import 'package:upmatev2/widgets/global/profile_picture.dart';

import '../../widgets/global/detail_profile_picture.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditProfileController>();
    final galleryController = Get.find<GalleryController>();
    final startController = Get.find<StartController>();
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            GetBuilder<EditProfileController>(
                builder: (_) => Column(
                      children: [
                        const SizedBox(
                          height: 93,
                        ),
                        SizedBox(
                          height: 260,
                          width: Get.width,
                          child: Stack(
                            fit: StackFit.expand,
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                top: 0,
                                child: SizedBox(
                                    height: 150,
                                    width: Get.width,
                                    child: Image.network(
                                      startController.user!.bannerUrl!,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Column(
                                  children: [
                                    GestureDetector(
                                        onTap: () => Get.to(
                                            () => const DetailProfilePicture(),
                                            opaque: false,
                                            fullscreenDialog: true,
                                            transition:
                                                Transition.circularReveal),
                                        child: Hero(
                                            tag: "pp_edit_profile",
                                            child: Container(
                                              height: 130,
                                              width: 130,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      width: 4,
                                                      color: Colors.white)),
                                              child: ProfilePicture(
                                                imageURL: startController
                                                    .user!.photoUrl,
                                                size: 120,
                                              ),
                                            ))),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          BottomSheetWidget.showChooseImage(
                                              controller, false),
                                      child: Text(
                                        "change_picture".tr,
                                        style: const TextStyle(
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                  top: 10,
                                  right: 10,
                                  child: GestureDetector(
                                    onTap: () =>
                                        BottomSheetWidget.showChooseImage(
                                            controller, true),
                                    child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Colors.black.withOpacity(0.3)),
                                        child: SvgPicture.asset(
                                          "assets/svg/edit.svg",
                                          colorFilter: const ColorFilter.mode(
                                              Colors.white, BlendMode.srcIn),
                                        )),
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children:
                                List.generate(controller.data!.length, (index) {
                              final Map<String, dynamic> data =
                                  controller.data!;
                              return GestureDetector(
                                onTap: () {
                                  controller.chooseInput(
                                      controller.data!.keys.elementAt(index));
                                  Get.to(() => EditPage(index: index),
                                      transition: Transition.rightToLeft);
                                },
                                child: Container(
                                  color: Colors.white,
                                  height: 50,
                                  width: Get.width,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15.0),
                                              child: Text(
                                                data.keys.elementAt(index),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                          Expanded(
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(data.values
                                                      .elementAt(index)))),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15.0),
                                              child: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: Colors.black,
                                                size: 20,
                                              ))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: Get.width,
                                        height: 0.5,
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        )
                      ],
                    )),
            const AppBarEditProfile(),
            Obx(() => galleryController.isLoading.value
                ? const BlurLoading()
                : const SizedBox())
          ],
        ),
      ),
    );
  }
}
