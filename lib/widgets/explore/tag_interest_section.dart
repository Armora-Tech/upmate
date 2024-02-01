import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_font.dart';

class TagInterestSection extends StatelessWidget {
  const TagInterestSection({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> exploreTags = [
      {"name": "math".tr, "image": "assets/images/math.jpg"},
      {"name": "programming".tr, "image": "assets/images/programming.jpg"},
      {"name": "economy".tr, "image": "assets/images/economy.jpg"},
      {"name": "algebra".tr, "image": "assets/images/algebra.jpg"},
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text("${"your_interest_tags".tr} #",
              style: AppFont.text16.copyWith(fontWeight: FontWeight.bold)),
        ),
        Wrap(
          runSpacing: 10,
          spacing: 10,
          direction: Axis.horizontal,
          children: List.generate(
            exploreTags.length,
            (index) => SizedBox(
              height: 180,
              width: Get.width / 2 - 25,
              child: Material(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () {},
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Ink.image(
                          image: AssetImage(exploreTags[index]["image"]!),
                          fit: BoxFit.cover),
                      Container(
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                                Color.fromARGB(127, 0, 0, 0),
                                Color.fromARGB(230, 0, 0, 0)
                              ]),
                        ),
                        child: Text(
                          "#${exploreTags[index]["name"]!}",
                          maxLines: 3,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
