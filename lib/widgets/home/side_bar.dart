import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/login_controller.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_font.dart';
import 'package:upmatev2/widgets/global/detail_profile_picture.dart';
import '../global/line.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StartController>();
    final loginController = Get.find<LoginController>();
    Map<dynamic, dynamic> content = {
      "account".tr: Icons.account_circle_outlined,
      "settings".tr: Icons.settings_outlined,
      "privacy".tr: Icons.lock_outlined,
      "bookmarks".tr: Icons.bookmark_outline_outlined,
      "help_center".tr: Icons.help_outline_outlined,
      "FAQ": Icons.help_center_outlined,
      "logout".tr: Icons.logout,
    };
    return Drawer(
      backgroundColor: Colors.white,
      clipBehavior: Clip.none,
      shape: Border.all(
        width: 0,
      ),
      child: Column(
        children: [
          Container(
              height: 190,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 24, 36, 41),
                border:
                    Border.all(width: 0, strokeAlign: 10, color: Colors.white),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              child: Container(
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
                          transition: Transition.circularReveal),
                      child: Hero(
                        tag: "pp_side_bar",
                        child: Container(
                          height: 60,
                          width: 60,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              border:
                                  Border.all(width: 1.5, color: Colors.white),
                              shape: BoxShape.circle),
                          child: ClipOval(
                            child: Image.network(
                              controller.photoURL!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      controller.displayName!,
                      style: AppFont.text20.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    Text(
                      controller.usernameWithAt,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )),
          const SizedBox(
            height: 5.0,
          ),
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
                          await loginController.signOut();
                        }
                      },
                      child: Column(
                        children: [
                          item.key == "logout".tr
                              ? const Line()
                              : const SizedBox.shrink(),
                          Container(
                              width: Get.size.width,
                              color: Colors.transparent,
                              margin: const EdgeInsets.only(right: 20),
                              padding: const EdgeInsets.only(left: 20),
                              height: 50,
                              child: Row(
                                children: [
                                  Icon(
                                    item.value,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    item.key,
                                    style: AppFont.text12
                                        .copyWith(fontWeight: FontWeight.w600),
                                  )
                                ],
                              )),
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
