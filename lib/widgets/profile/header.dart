import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/start_controller.dart';

import '../global/detail_profile_picture.dart';
import '../global/profile_picture.dart';

class HeaderProfile extends StatelessWidget {
  const HeaderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final startController = Get.find<StartController>();
    return SizedBox(
      height: 200,
      width: Get.width,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            child: SizedBox(
                height: 150,
                width: Get.width,
                child: Image.network(
                  startController.user!.bannerUrl!,
                  fit: BoxFit.cover,
                )),
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
            bottom: 5,
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
                  border: Border.all(width: 3, color: Colors.white),
                ),
                child: Hero(
                  tag: "profile",
                  child: ProfilePicture(
                      imageURL: startController.user!.photoUrl, size: 75),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
