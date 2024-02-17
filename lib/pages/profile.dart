import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/widgets/profile/description.dart';
import 'package:upmatev2/widgets/profile/header.dart';
import 'package:upmatev2/widgets/profile/main_content.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final startController = Get.find<StartController>();
    controller.isFullText.value = false;
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<ProfileController>(
          builder: (_) => NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  // expandedHeight: controller.isFullText.value ? 485.0 : 440.0,
                  expandedHeight: controller.isFullText.value
                      ? Get.width * 9 / 16 + 305
                      : (startController.user!.bio == null ||
                              startController.user!.bio == "")
                          ? Get.width * 9 / 16 + 195
                          : Get.width * 9 / 16 + 245,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderProfile(user: startController.user!),
                        const SizedBox(height: 5),
                        DescriptionProfile(user: startController.user!)
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MainContent(),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller.tabController,
                    children: List.generate(controller.pages.length,
                        (index) => controller.pages[index]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
