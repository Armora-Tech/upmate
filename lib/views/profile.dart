import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_font.dart';
import 'package:upmatev2/widgets/global/profile_picture.dart';
import 'package:upmatev2/widgets/profile/main_content.dart';

import '../controllers/profile_controller.dart';
import '../themes/app_color.dart';
import '../widgets/global/detail_profile_picture.dart';

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
                        SizedBox(
                          height: 150,
                          width: Get.width,
                          child: Stack(
                            fit: StackFit.expand,
                            clipBehavior: Clip.none,
                            children: [
                              Image.asset(
                                "assets/images/wallpaper_flutter.jpg",
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 15,
                                left: 15,
                                child: GestureDetector(
                                  onTap: () => Get.back(),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(123, 255, 255, 255),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: -45,
                                left: 15,
                                child: GestureDetector(
                                  onTap: () => Get.to(
                                    () => const DetailProfilePicture(),
                                    opaque: false,
                                    fullscreenDialog: true,
                                    transition: Transition.circularReveal,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 3, color: Colors.white),
                                    ),
                                    child: Hero(
                                      tag: "profile",
                                      child: ProfilePicture(
                                          imageURL: startController.photoURL,
                                          size: 75),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                startController.displayName!,
                                maxLines: 1,
                                style: AppFont.text16
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                startController.username,
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
                                              children: const [
                                                TextSpan(
                                                  text: "Mengikuti  ",
                                                ),
                                                TextSpan(
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
                                              children: const [
                                                TextSpan(
                                                  text: "Pengikut  ",
                                                ),
                                                TextSpan(
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
                                          "Edit Profil",
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
