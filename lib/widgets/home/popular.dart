import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Popular extends StatelessWidget {
  const Popular({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> popular = [
      {
        "type": "Topik",
        "title": "UI/IX Design",
        "info":
            "Diikuti oleh Percy Hedinson, Riska Nur, Lia Dahlia dan 9 Lainnya"
      },
      {
        "type": "Forum",
        "title": "Programming",
        "info": "Disarankan untuk anda"
      },
      {
        "type": "Topik",
        "title": "UI/IX Design",
        "info":
            "Diikuti oleh Percy Hedinson, Riska Nur, Lia Dahlia dan 9 Lainnya"
      },
      {
        "type": "Forum",
        "title": "Programming",
        "info": "Disarankan untuk anda"
      },
    ];
    return SizedBox(
      height: 280,
      width: Get.width,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        separatorBuilder: (context, index) => const SizedBox(
          width: 20,
        ),
        itemCount: popular.length,
        itemBuilder: (context, index) {
          return Container(
              width: 180,
              height: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(15)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    "assets/images/ui_ux.jpg",
                    fit: BoxFit.cover,
                  ),
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
                            filter: ImageFilter.blur(
                                sigmaX: 5,
                                sigmaY:
                                    5), // Adjust sigmaX and sigmaY for blur intensity
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              color: Colors.grey.withOpacity(
                                  0.3), // Adjust opacity and color for the blur effect
                              child: Text(
                                popular[index]["type"],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      )),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        height: 120,
                        constraints: const BoxConstraints(maxWidth: 180),
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: 5,
                                sigmaY:
                                    5), // Adjust sigmaX and sigmaY for blur intensity
                            child: Container(
                              height: 120,
                              constraints: const BoxConstraints(maxWidth: 180),
                              color: Colors.grey.withOpacity(
                                  0.3), // Adjust opacity and color for the blur effect
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        popular[index]["title"],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        popular[index]["info"],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0),
                                        side: const BorderSide(
                                            width: 0.3, color: Colors.white),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Ikuti",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                ],
              ));
        },
      ),
    );
  }
}
