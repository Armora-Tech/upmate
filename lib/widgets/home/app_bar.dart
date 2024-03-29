import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/bottom_nav_controller.dart';

import '../../controllers/home_controller.dart';
import '../../controllers/start_controller.dart';
import '../../routes/route_name.dart';
import '../../themes/app_color.dart';
import '../../themes/app_font.dart';
import '../global/profile_picture.dart';
import '../global/skelton.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final startController = Get.find<StartController>();
    final controller = Get.find<HomeController>();
    final bottNavController = Get.find<BottomNavController>();
    return Positioned(
      top: 0,
      child: Container(
        color: Colors.white,
        width: Get.width,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 60,
                  child: GetBuilder<StartController>(
                    builder: (_) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GetBuilder<HomeController>(
                          builder: (_) => GestureDetector(
                            onTap: controller.isLoading.value
                                ? () {}
                                : () {
                                    Scaffold.of(context).openDrawer();
                                    bottNavController.update();
                                  },
                            child: SizedBox(
                              width: 28,
                              child: Image.asset(
                                  "assets/images/humberger_icon.png",
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(startController.user?.displayName ?? "",
                                textAlign: TextAlign.center,
                                style: AppFont.text20.copyWith(
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis)),
                          ),
                        ),
                        startController.isLoading.value
                            ? const ShimmerSkelton(
                                height: 35, width: 35, isCircle: true)
                            : GetBuilder<HomeController>(
                                builder: (_) => GestureDetector(
                                  onTap: controller.isLoading.value
                                      ? () {}
                                      : () => Get.toNamed(RouteName.profile),
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: const BoxDecoration(
                                        color: AppColor.lightGrey,
                                        shape: BoxShape.circle),
                                    child: ProfilePicture(
                                        imageURL:
                                            startController.user?.photoUrl,
                                        size: 35),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(height: 0.5, width: Get.width, color: Colors.grey)
            ],
          ),
        ),
      ),
    );
  }
}
