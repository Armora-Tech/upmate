import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/widgets/global/detail_profile_picture.dart';

class ProfilePicture extends StatelessWidget {
  final double size;
  final String tag;
  const ProfilePicture({super.key, required this.size, required this.tag});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Get.to(() => const DetailProfilePicture(),
            opaque: false,
            fullscreenDialog: true,
            transition: Transition.circularReveal),
        child: Hero(
          tag: tag,
          child: Container(
            width: size,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Image.network(
              "https://i.pinimg.com/736x/e5/93/09/e593098f04ed9c1f5fa05749ff0aff26.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ));
  }
}
