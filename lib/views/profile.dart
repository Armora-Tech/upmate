import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/widgets/profile/description.dart';
import 'package:upmatev2/widgets/profile/header.dart';
import 'package:upmatev2/widgets/profile/main_content.dart';
import 'package:upmatev2/widgets/profile/other_user_post.dart';

import '../controllers/profile_controller.dart';
import '../widgets/global/line.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final startController = Get.find<StartController>();
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
                  expandedHeight: controller.isFullText.value ? 485.0 : 440.0,
                  flexibleSpace: const FlexibleSpaceBar(
                    background: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderProfile(),
                        SizedBox(height: 5),
                        DescriptionProfile()
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: controller.otherUser.uid == startController.user!.uid
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MainContent(),
                      Expanded(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: controller.tabController,
                          children: List.generate(
                            controller.pages.length,
                            (index) => controller.pages[index],
                          ),
                        ),
                      ),
                    ],
                  )
                : const Column(children: [
                    SizedBox(
                      height: 20,
                    ),
                    Line(),
                    Expanded(child: OtherUserPost())
                  ]),
          ),
        ),
      ),
    );
  }
}
