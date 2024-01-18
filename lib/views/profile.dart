import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_font.dart';
import 'package:upmatev2/widgets/profile/header.dart';
import 'package:upmatev2/widgets/profile/main_content.dart';

import '../controllers/profile_controller.dart';
import '../themes/app_color.dart';

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
                  expandedHeight: 405.0,
                  floating: false,
                  pinned: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HeaderProfile(),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                startController.user!.displayName,
                                maxLines: 1,
                                style: AppFont.text16
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                startController.user!.username,
                                maxLines: 1,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const Text(
                                "Ada yang mau ikut aku???, ayo ikut ke dunia Flora simsalabim akan ku buat harimu menjadi penuh cinta. Hai Semuanya aku Flora",
                                maxLines: 3,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      decoration: BoxDecoration(
                                          color: AppColor.lightGrey,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                        child: RichText(
                                          text: TextSpan(
                                              style: AppFont.text14,
                                              children: [
                                                TextSpan(
                                                  text: "${"following".tr}  ",
                                                ),
                                                const TextSpan(
                                                    text: "5",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ]),
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      decoration: BoxDecoration(
                                          color: AppColor.lightGrey,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                        child: RichText(
                                          text: TextSpan(
                                              style: AppFont.text14,
                                              children: [
                                                TextSpan(
                                                  text: "${"followers".tr}  ",
                                                ),
                                                const TextSpan(
                                                    text: "5",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ]),
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColor.lightGrey,
                                          padding: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                        onPressed: () {},
                                        child: const Icon(
                                          Icons.person_add,
                                          size: 20,
                                          color: Colors.black,
                                        )),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                  height: 35,
                                  child: ElevatedButton(
                                      onPressed: () =>
                                          Get.toNamed(RouteName.editProfile),
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5))),
                                      child: Center(
                                        child: Text(
                                          "edit_profile".tr,
                                          style: AppFont.text14.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ))),
                            ],
                          ),
                        ),
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
                    children: List.generate(
                      controller.pages.length,
                      (index) => controller.pages[index],
                    ),
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
