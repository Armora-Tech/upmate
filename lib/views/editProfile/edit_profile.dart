import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/edit_profile_controller.dart';
import 'package:upmatev2/controllers/gallery_controller.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/widgets/editProfile/app_bar.dart';
import 'package:upmatev2/widgets/global/banner.dart';
import 'package:upmatev2/widgets/global/blur_loading.dart';
import 'package:upmatev2/widgets/global/bottom_sheet.dart';
import 'package:upmatev2/widgets/global/detail_banner.dart';
import 'package:upmatev2/widgets/global/profile_picture.dart';

import '../../widgets/editProfile/user_data.dart';
import '../../widgets/global/detail_profile_picture.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditProfileController>();
    final galleryController = Get.find<GalleryController>();
    final startController = Get.find<StartController>();
    return WillPopScope(
        onWillPop: () async {
          if (!galleryController.isLoading.value) {
            Get.back();
          }
          return Future.value(false);
        },
        child: Scaffold(
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Stack(
              children: [
                GetBuilder<EditProfileController>(
                    builder: (_) => Column(
                          children: [
                            const SizedBox(
                              height: 93.16,
                            ),
                            SizedBox(
                              height: 310,
                              width: Get.width,
                              child: Stack(
                                fit: StackFit.expand,
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    top: 0,
                                    child: GestureDetector(
                                        onTap: () => Get.to(
                                            () => const DetailBanner(),
                                            opaque: false,
                                            fullscreenDialog: true,
                                            transition:
                                                Transition.noTransition),
                                        child: const Hero(
                                            tag: "banner_edit_profile",
                                            child: MyBanner())),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                            onTap: () => Get.to(
                                                () =>
                                                    const DetailProfilePicture(),
                                                opaque: false,
                                                fullscreenDialog: true,
                                                transition:
                                                    Transition.noTransition),
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
                                                color: Colors.black
                                                    .withOpacity(0.3)),
                                            child: SvgPicture.asset(
                                              "assets/svg/edit.svg",
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                      Colors.white,
                                                      BlendMode.srcIn),
                                            )),
                                      ))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const UserDataEditProfile()
                          ],
                        )),
                const AppBarEditProfile(),
                Obx(() => galleryController.isLoading.value
                    ? const BlurLoading()
                    : const SizedBox())
              ],
            ),
          ),
        ));
  }
}
