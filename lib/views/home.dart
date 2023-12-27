import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_font.dart';
import 'package:upmatev2/widgets/global/title_section.dart';
import 'package:upmatev2/widgets/home/new_post.dart';
import 'package:upmatev2/widgets/home/popular.dart';
import '../controllers/home_controller.dart';
import '../widgets/global/profile_picture.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final startController = Get.find<StartController>();
    return Obx(
      () => controller.isLoading.value
          ? const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            )
          : Scaffold(
              body: Stack(children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 75,
                      ),
                      const NewPost(),
                      const SizedBox(
                        height: 10,
                      ),
                      TitleSection(title: "popular".tr),
                      const SizedBox(
                        height: 20,
                      ),
                      const Popular(),
                      const SizedBox(
                        height: 20,
                      ),
                      TitleSection(title: "people_with_similar_interests".tr),
                      const SizedBox(
                        height: 20,
                      ),
                      const Popular(),
                      const SizedBox(
                        height: 100,
                      ),
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        Scaffold.of(context).openDrawer(),
                                    child: SizedBox(
                                        width: 28,
                                        child: Image.asset(
                                          "assets/images/humberger_icon.png",
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  Text(
                                    startController.displayName!,
                                    style: AppFont.text20
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  GestureDetector(
                                      onTap: () =>
                                          Get.toNamed(RouteName.profile),
                                      child: ProfilePicture(
                                        imageURL: startController.photoURL,
                                        size: 35,
                                      ))
                                ],
                              ),
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
              ]),
            ),
    );
  }
}
