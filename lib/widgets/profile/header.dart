import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/profile_controller.dart';
import 'package:upmatev2/widgets/global/banner.dart';

import '../global/detail_banner.dart';
import '../global/detail_profile_picture.dart';
import '../global/profile_picture.dart';

class HeaderProfile extends StatelessWidget {
  const HeaderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return SizedBox(
      height: 250,
      width: Get.width,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            child: GestureDetector(
                onTap: controller.otherUser.bannerUrl == null
                    ? () {}
                    : () => Get.to(
                        () => DetailBanner(
                              otherUserPhoto: controller.otherUser.bannerUrl,
                            ),
                        opaque: false,
                        fullscreenDialog: true,
                        transition: Transition.noTransition),
                child: Hero(
                    tag: "banner_profile",
                    child: MyBanner(
                      otherUserPhoto: controller.otherUser.bannerUrl,
                    ))),
          ),
          Positioned(
            top: 15,
            left: 15,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(123, 255, 255, 255),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 15,
            child: GestureDetector(
              onTap: () => Get.to(
                () => DetailProfilePicture(
                    otherUserPhoto: controller.otherUser.photoUrl),
                opaque: false,
                fullscreenDialog: true,
                transition: Transition.noTransition,
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 3, color: Colors.white),
                ),
                child: Hero(
                  tag: "profile",
                  child: ProfilePicture(
                      imageURL: controller.otherUser.photoUrl, size: 75),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
