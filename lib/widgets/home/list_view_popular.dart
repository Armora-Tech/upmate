import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/themes/app_font.dart';

class ListViewPopular extends StatelessWidget {
  const ListViewPopular({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> popular = [
      {
        "type": "topic".tr,
        "title": "programming".tr,
        "image": "assets/images/programming.jpg",
        "info": "recommended_for_you".tr
      },
      {
        "type": "Forum",
        "title": "math".tr,
        "image": "assets/images/math.jpg",
        "info": "recommended_for_you".tr
      },
      {
        "type": "topic".tr,
        "title": "algebra".tr,
        "image": "assets/images/algebra.jpg",
        "info": "recommended_for_you".tr
      },
      {
        "type": "Forum",
        "title": "economy".tr,
        "image": "assets/images/economy.jpg",
        "info": "recommended_for_you".tr
      }
    ];
    const double containerWidth = 180;
    return SizedBox(
      height: 280,
      width: Get.width,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        separatorBuilder: (context, index) => const SizedBox(width: 20),
        itemCount: popular.length,
        itemBuilder: (context, index) {
          return Container(
            width: containerWidth,
            height: 250,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(15)),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(popular[index]["image"], fit: BoxFit.cover),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 0.3, color: Colors.white),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          color: Colors.grey.withOpacity(0.3),
                          child: Text(
                            popular[index]["type"],
                            style: AppFont.text12.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    height: 120,
                    width: containerWidth,
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          height: 120,
                          width: containerWidth,
                          color: Colors.grey.withOpacity(0.3),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    popular[index]["title"],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    popular[index]["info"],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppFont.text10
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 0),
                                    side: const BorderSide(
                                        width: 0.3, color: Colors.white),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "follow".tr,
                                      style: AppFont.text12
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
