import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:upmatev2/themes/app_font.dart';
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
                    text: TextSpan(style: AppFont.defaultText, children: [
                      const TextSpan(
                        text: "Muhammad Rafli Silehu",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text: " menyukai postingan Anda.",
                          style: AppFont.semiMediumText),
                      const WidgetSpan(
                          child: SizedBox(
                        width: 5,
                      )),
                      TextSpan(
                          text: "3 jam ",
                          style: AppFont.semiMediumText
                              .copyWith(color: Colors.grey)),
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
