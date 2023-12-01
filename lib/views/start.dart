import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/bottom_nav_controller.dart';
import 'package:upmatev2/themes/app_color.dart';

class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    final botNavController = Get.find<BottomNavController>();
    return Obx(() => Scaffold(
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                  width: 30, child: Icon(Icons.menu)),
                              const Text(
                                "Flora Shafiqa",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: 35,
                                clipBehavior: Clip.hardEdge,
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: Image.network(
                                  "https://i.pinimg.com/736x/e5/93/09/e593098f04ed9c1f5fa05749ff0aff26.jpg",
                                  fit: BoxFit.cover,
                                ),
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
                  height: 70,
                  width: Get.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 0.5,
                        width: Get.width,
                        color: AppColor.lightGrey,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(botNavController.tabs.length,
                              (index) {
                            final item = botNavController.tabs;
                            return GestureDetector(
                              onTap: () => botNavController.selectTab(index),
                              child: SizedBox(
                                width: Get.width / 5 - 20,
                                child: Column(
                                  children: [
                                    Icon(
                                      item.values.elementAt(index)[
                                          botNavController.selectedTab.value ==
                                                  index
                                              ? 1
                                              : 0],
                                      size: 28,
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
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
