import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/bottom_nav_controller.dart';
import 'package:upmatev2/controllers/home_controller.dart';
import 'package:upmatev2/widgets/global/line.dart';
import '../widgets/global/blur_loading.dart';
import '../widgets/home/side_bar.dart';

class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    final botNavController = Get.find<BottomNavController>();
    final homeController = Get.find<HomeController>();
    final List<Map<String, dynamic>> tabs = [
      {
        "name": "home".tr,
        "icon": "assets/svg/home_outlined.svg",
        "active_icon": "assets/svg/home.svg"
      },
      {
        "name": "explore".tr,
        "icon": "assets/svg/explore_outlined.svg",
        "active_icon": "assets/svg/explore.svg"
      },
      {
        "name": "Post",
        "icon": "assets/svg/post.svg",
        "active_icon": "assets/svg/post.svg"
      },
      {
        "name": "notification".tr,
        "icon": "assets/svg/notification_outlined.svg",
        "active_icon": "assets/svg/notification.svg"
      },
      {
        "name": "chat".tr,
        "icon": "assets/svg/chat_outlined.svg",
        "active_icon": "assets/svg/chat.svg"
      },
    ];
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        drawerEnableOpenDragGesture: false,
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
              bottom: 0,
              width: Get.width,
              child: Container(
                color: Colors.white,
                height: 60,
                width: Get.width,
                child: Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        tabs.length,
                        (index) {
                          final item = tabs;
                          return GestureDetector(
                            onTapUp: (details) {
                              botNavController.iconSize.value =
                                  botNavController.initialIconSize.value;
                              botNavController.textSize.value =
                                  botNavController.initialTextSize.value;
                            },
                            onTapDown: (details) {
                              botNavController.iconSize.value = 23;
                              botNavController.textSize.value = 8;
                              botNavController.selectTab(index);
                            },
                            onTapCancel: () {
                              botNavController.iconSize.value =
                                  botNavController.initialIconSize.value;
                              botNavController.textSize.value =
                                  botNavController.initialTextSize.value;
                            },
                            child: Container(
                              color: Colors.white,
                              width: botNavController.widthTab.value,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      botNavController.selectedTab.value ==
                                              index
                                          ? item.elementAt(index)["active_icon"]
                                          : item.elementAt(index)["icon"],
                                      height:
                                          botNavController.selectedTab.value ==
                                                  index
                                              ? botNavController.iconSize.value
                                              : botNavController
                                                  .initialIconSize.value,
                                      width:
                                          botNavController.selectedTab.value ==
                                                  index
                                              ? botNavController.iconSize.value
                                              : botNavController
                                                  .initialIconSize.value,
                                      semanticsLabel:
                                          item.elementAt(index)["name"]),
                                  const SizedBox(height: 2),
                                  Text(
                                    item.elementAt(index)["name"],
                                    style: TextStyle(
                                        fontSize: botNavController
                                                    .selectedTab.value ==
                                                index
                                            ? botNavController.textSize.value
                                            : botNavController
                                                .initialTextSize.value,
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
                        },
                      ),
                    ),
                    const Positioned(top: 0, child: Line()),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      left: botNavController.handleBarAnimation(),
                      child: Container(
                        height: 3.5,
                        width: botNavController.widthTab.value,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GetBuilder<HomeController>(
                builder: (_) => homeController.isDeleting.value
                    ? const BlurLoading()
                    : const SizedBox())
          ],
        ),
      ),
    );
  }
}
