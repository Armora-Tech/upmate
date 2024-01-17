import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/notification_controller.dart';
import 'package:upmatev2/themes/app_font.dart';
import 'package:upmatev2/widgets/global/line.dart';
import 'package:upmatev2/widgets/global/title_section.dart';
import 'package:upmatev2/widgets/notification/follow.dart';
import 'package:upmatev2/widgets/notification/post.dart';
import 'package:upmatev2/widgets/notification/shimmer.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());
    controller.loading();
    return Obx(() => controller.isLoading.value
        ? const NotificationShimmer()
        : Stack(children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  TitleSection(title: "latest".tr),
                  const Follow(),
                  const Follow(),
                  const Follow(),
                  const Line(),
                  const SizedBox(
                    height: 10,
                  ),
                  TitleSection(title: "today".tr),
                  const SizedBox(
                    height: 5,
                  ),
                  const Post(),
                  const Post(),
                  const Post(),
                  const Line(),
                  const SizedBox(
                    height: 10,
                  ),
                  TitleSection(title: "yesterday".tr),
                  const Post(),
                  const Post(),
                  const Post(),
                  const Post(),
                  const Post(),
                ],
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                color: Colors.white,
                width: Get.width,
                child: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "notification".tr,
                              style: AppFont.text23.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SvgPicture.asset(
                              "assets/svg/more_vert.svg",
                              height: 22,
                            ),
                          ],
                        ),
                      ),
                      const Line()
                    ],
                  ),
                ),
              ),
            ),
          ]));
  }
}
