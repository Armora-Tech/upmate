import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/bottom_nav_controller.dart';
import 'package:upmatev2/widgets/global/line.dart';
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
                                      size:
                                          botNavController.selectedTab.value ==
                                                  index
                                              ? botNavController.iconSize.value
                                              : botNavController
                                                  .initialIconSize.value,
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      item.keys.elementAt(index),
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
                          }),
                        ),
                      ),
                      const Positioned(top: 0, child: Line())
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
