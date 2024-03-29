import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/themes/app_font.dart';
import 'package:upmatev2/widgets/global/detail_profile_picture.dart';
import 'package:upmatev2/widgets/home/confirm_logout.dart';
import '../global/cached_network_image.dart';
import '../global/line.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StartController>();
    Map<dynamic, dynamic> content = {
      "account".tr: "assets/svg/profile_outlined.svg",
      "settings".tr: "assets/svg/settings_outlined.svg",
      "privacy".tr: "assets/svg/privacy.svg",
      "bookmarks".tr: "assets/svg/bookmark_outlined.svg",
      "help_center".tr: "assets/svg/help_center.svg",
      "FAQ": "assets/svg/faq.svg",
      "logout".tr: "assets/svg/logout.svg"
    };
    return Drawer(
      backgroundColor: Colors.white,
      clipBehavior: Clip.none,
      shape: Border.all(width: 0),
      child: Column(
        children: [
          Container(
            height: 210,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 24, 36, 41),
              border:
                  Border.all(width: 0, strokeAlign: 10, color: Colors.white),
              borderRadius:
                  const BorderRadius.only(bottomRight: Radius.circular(20)),
            ),
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: Stack(
              children: [
                Container(
                  color: AppColor.primaryColor,
                  height: Get.height,
                  width: Get.width,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      controller.user!.bannerUrl == null
                          ? const SizedBox()
                          : CachedNetworkImageWidget(
                              imageUrl: controller.user!.bannerUrl!,
                              circularProgressSize: 20,
                              heightPlaceHolder: Get.height,
                              widthPlaceHolder: Get.width,
                              radiusPlaceHolder: 0,
                              fit: BoxFit.cover),
                      controller.user!.bannerUrl == null
                          ? const SizedBox()
                          : BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                              child: Container(
                                height: Get.height,
                                width: Get.width,
                                color: const Color.fromARGB(106, 0, 0, 0),
                              ),
                            )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  width: Get.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Get.to(() => const DetailProfilePicture(),
                            opaque: false,
                            fullscreenDialog: true,
                            transition: Transition.noTransition),
                        child: Hero(
                          tag: "pp_side_bar",
                          child: Container(
                            height: 75,
                            width: 75,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                border:
                                    Border.all(width: 1.5, color: Colors.white),
                                shape: BoxShape.circle),
                            child: ClipOval(
                              child: CachedNetworkImageWidget(
                                  imageUrl: controller.user!.photoUrl!,
                                  circularProgressSize: 20,
                                  heightPlaceHolder: 75,
                                  widthPlaceHolder: 75,
                                  radiusPlaceHolder: 75,
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Text(
                        controller.user!.displayName,
                        style: AppFont.text20.copyWith(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      Text(
                        controller.user!.username,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5.0),
          Column(
              children: content.entries
                  .map(
                    (item) => GestureDetector(
                      onTap: () async {
                        var key = item.key;
                        if (key == "account".tr) {
                          Get.toNamed(RouteName.profile);
                        } else if (key == "settings".tr) {
                          Get.toNamed(RouteName.settings);
                        } else if (key == "logout".tr) {
                          ConfirmLogoutDialog.showDialog();
                        } else if (key == "bookmarks".tr) {
                          controller.isShowingBookmarks.value = true;
                          Get.toNamed(RouteName.profile);
                        }
                      },
                      child: Column(
                        children: [
                          item.key == "logout".tr
                              ? const Line()
                              : const SizedBox(),
                          Container(
                            width: Get.size.width,
                            color: Colors.transparent,
                            margin: const EdgeInsets.only(right: 20),
                            padding: const EdgeInsets.only(left: 20),
                            height: 50,
                            child: Row(
                              children: [
                                SvgPicture.asset(item.value,
                                    height: 20,
                                    width: 20,
                                    semanticsLabel: item.key),
                                const SizedBox(width: 10.0),
                                Text(item.key,
                                    style: AppFont.text12
                                        .copyWith(fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList())
        ],
      ),
    );
  }
}
