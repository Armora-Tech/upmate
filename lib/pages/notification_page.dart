import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/notification_controller.dart';
import 'package:upmatev2/widgets/global/line.dart';
import 'package:upmatev2/widgets/global/title_section.dart';
import 'package:upmatev2/widgets/notification/app_bar.dart';
import 'package:upmatev2/widgets/notification/follow.dart';
import 'package:upmatev2/widgets/notification/post.dart';
import 'package:upmatev2/widgets/notification/shimmer.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());
    controller.loading();
    return Obx(
      () => controller.isLoading.value
          ? const NotificationShimmer()
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100),
                      TitleSection(title: "latest".tr),
                      const Follow(),
                      const Follow(),
                      const Follow(),
                      const Line(),
                      const SizedBox(height: 10),
                      TitleSection(title: "today".tr),
                      const SizedBox(height: 5),
                      const Post(),
                      const Post(),
                      const Post(),
                      const Line(),
                      const SizedBox(height: 10),
                      TitleSection(title: "yesterday".tr),
                      const Post(),
                      const Post(),
                      const Post(),
                      const Post(),
                      const Post(),
                    ],
                  ),
                ),
                const NotificationAppBar()
              ],
            ),
    );
  }
}
