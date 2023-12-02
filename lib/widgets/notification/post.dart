import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:upmatev2/widgets/global/profile_picture.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: Get.width,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ProfilePicture(size: 40),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: RichText(
                    text: const TextSpan(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: "Nunito"),
                        children: [
                          TextSpan(
                            text: "Muhammad Rafli Silehu",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: " menyukai postingan Anda.",
                          ),
                          TextSpan(
                              text: "3 jam ",
                              style: TextStyle(color: Colors.grey)),
                        ]),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 50,
            child: Image.asset(
              "assets/images/quran.png",
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
