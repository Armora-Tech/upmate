import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/widgets/global/profile_picture.dart';
import 'package:upmatev2/widgets/profile/main_content.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return SafeArea(
      child: Scaffold(
          body: GetBuilder<ProfileController>(
        builder: (_) => SingleChildScrollView(
          child: Column(
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
                                shape: BoxShape.circle),
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
                          bottom: -73,
                          left: 15,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 3, color: Colors.white)),
                            child: const ProfilePicture(size: 75),
                          ))
                    ]),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Flora Shafiqa",
                      maxLines: 1,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "@florashafiqa",
                      maxLines: 1,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const Text(
                      "Ada yang mau ikut aku???, ayo ikut ke dunia Flora simsalabim akan ku buat harimu menjadi penuh cinta. Hai Semuanya aku Flora",
                      maxLines: 5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                            height: 30,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                color: AppColor.lightGrey,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: "Nunito"),
                                    children: [
                                      TextSpan(
                                        text: "Mengikuti  ",
                                      ),
                                      TextSpan(
                                          text: "5",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ]),
                              ),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                            height: 30,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                color: AppColor.lightGrey,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: "Nunito"),
                                    children: [
                                      TextSpan(
                                        text: "Pengikut  ",
                                      ),
                                      TextSpan(
                                          text: "5",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
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
                                    borderRadius: BorderRadius.circular(5)),
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
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          child: const Center(
                            child: Text(
                              "Edit Profil",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14),
                            ),
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const MainContent(),
              SizedBox(
                height: 300,
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  viewportFraction: 1,
                  controller: controller.tabController,
                  children: List.generate(controller.pages.length,
                      (index) => controller.pages[index]),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
