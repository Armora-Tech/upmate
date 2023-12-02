import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/bottom_nav_controller.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/widgets/global/profile_picture.dart';

import '../widgets/home/side_bar.dart';

class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    final botNavController = Get.find<BottomNavController>();
    return Obx(() => Scaffold(
          drawer: const SideBar(),
          body: Stack(
            fit: StackFit.expand,
            children: [
              TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                viewportFraction: 1,
                controller: botNavController.tabController,
                children: List.generate(botNavController.pages.length,
                    (index) => botNavController.pages[index]),
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Builder(
                                builder: (context) => GestureDetector(
                                  onTap: () =>
                                      Scaffold.of(context).openDrawer(),
                                  child: SizedBox(
                                      width: 28,
                                      child: Image.asset(
                                        "assets/images/humberger_icon.png",
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                              const Text(
                                "Flora Shafiqa",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const ProfilePicture(
                                size: 35,
                                tag: "app_bar",
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 0.5,
                          width: Get.width,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  color: Colors.white,
                  height: 60,
                  width: Get.width,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(botNavController.tabs.length,
                              (index) {
                            final item = botNavController.tabs;
                            return GestureDetector(
                              onTap: () => botNavController.selectTab(index),
                              child: Container(
                                color: Colors.white,
                                width: Get.width / 5 - 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      item.values.elementAt(index)[
                                          botNavController.selectedTab.value ==
                                                  index
                                              ? 1
                                              : 0],
                                      size: 25,
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      item.keys.elementAt(index),
                                      style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: botNavController
                                                      .selectedTab.value ==
                                                  index
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        child: Container(
                          height: 0.5,
                          width: Get.width,
                          color: AppColor.lightGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
