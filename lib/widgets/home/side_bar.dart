import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/widgets/global/detail_profile_picture.dart';

import '../../utils/auth.dart';
import '../global/line.dart';

class SideBar extends StatelessWidget {
  SideBar({super.key});

  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> content = {
      "Akun": Icons.account_circle_outlined,
      "Pengaturan": Icons.settings_outlined,
      "Privasi": Icons.lock_outlined,
      "Bookmarks": Icons.bookmark_outline_outlined,
      "Pusat Bantuan": Icons.help_outline_outlined,
      "FAQ": Icons.help_center_outlined,
      "Keluar": Icons.logout,
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
                              "https://i.pinimg.com/736x/e5/93/09/e593098f04ed9c1f5fa05749ff0aff26.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Text(
                      "Flora Shafiqa",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const Text(
                      "@florashafiqa",
                      style: TextStyle(color: Colors.grey),
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
                        var key = item.key.toLowerCase();
                        if (key == "akun") {
                          Get.toNamed(RouteName.profile);
                        } else if (item.key.toLowerCase() == "pengaturan") {
                          Get.toNamed(RouteName.editProfile);
                        } else if (key == "keluar") {
                          try {
                            _auth.signOut();
                          } catch (e) {
                            if (kDebugMode) {
                              print('Error navigating to start page: $e');
                              print("Sign out failed!");
                            }
                          }
                        }
                      },
                      child: Column(
                        children: [
                          item.key.toLowerCase() == "keluar"
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
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
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
