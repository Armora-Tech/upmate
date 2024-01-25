import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/themes/app_font.dart';

class Comment extends StatelessWidget {
  const Comment({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Row(
        children: [
          Container(
            width: 25,
            margin: const EdgeInsets.only(right: 10),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Image.network(
              "https://i.pinimg.com/736x/e5/93/09/e593098f04ed9c1f5fa05749ff0aff26.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: AppFont.text14,
                    children: const [
                      TextSpan(
                        text: "Flora Shafiqa ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: "Keren banget kak (emot api)"),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text("2 ${"hours".tr}",
                        style: AppFont.text12.copyWith(color: Colors.grey)),
                    const SizedBox(width: 10),
                    Text("1 ${"like".tr}",
                        style: AppFont.text12.copyWith(color: Colors.grey)),
                    const SizedBox(width: 10),
                    Text("reply".tr,
                        style: AppFont.text12.copyWith(color: Colors.grey)),
                    const SizedBox(width: 10),
                    Text("send".tr,
                        style: AppFont.text12.copyWith(color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
