import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/widgets/global/title_section.dart';
import 'package:upmatev2/widgets/home/new_post.dart';
import 'package:upmatev2/widgets/home/popular.dart';

import '../controllers/home_controller.dart';
import '../widgets/global/detail_profile_picture.dart';
import '../widgets/global/profile_picture.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.put(HomeController());

  @override
  void dispose() {
    Get.delete<HomeController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              NewPost(),
              SizedBox(
                height: 10,
              ),
              TitleSection(title: "Popular"),
              SizedBox(
                height: 20,
              ),
              Popular(),
              SizedBox(
                height: 20,
              ),
              TitleSection(title:  "Orang dengan ketertarikan yang sama"),
              SizedBox(
                height: 20,
              ),
              Popular(),
              SizedBox(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Scaffold.of(context).openDrawer(),
                            child: SizedBox(
                                width: 28,
                                child: Image.asset(
                                  "assets/images/humberger_icon.png",
                                  fit: BoxFit.cover,
                                )),
                          ),
                          const Text(
                            "Flora Shafiqa",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                              onTap: () => Get.to(
                                  () => const DetailProfilePicture(),
                                  opaque: false,
                                  fullscreenDialog: true,
                                  transition: Transition.circularReveal),
                              child: const Hero(
                                  tag: "app_bar",
                                  child: ProfilePicture(
                                    size: 35,
                                  )))
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
    );
  }
}
