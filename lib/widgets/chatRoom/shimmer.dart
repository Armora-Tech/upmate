import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:upmatev2/widgets/global/skelton.dart';

import '../../themes/app_color.dart';
import '../global/line.dart';

class ChatRoomShimmer extends StatelessWidget {
  const ChatRoomShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    double defaultRadius = 20;
    double taperRadius = 3;
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 120,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10, bottom: 3),
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(defaultRadius),
                                topRight: Radius.circular(defaultRadius),
                                bottomLeft: Radius.circular(defaultRadius),
                                bottomRight: Radius.circular(taperRadius))),
                      )),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10, bottom: 3),
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(defaultRadius),
                                topRight: Radius.circular(taperRadius),
                                bottomLeft: Radius.circular(defaultRadius),
                                bottomRight: Radius.circular(taperRadius))),
                      )),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: const EdgeInsets.only(
                          right: 10,
                          bottom: 3,
                        ),
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(defaultRadius),
                                topRight: Radius.circular(taperRadius),
                                bottomLeft: Radius.circular(defaultRadius),
                                bottomRight: Radius.circular(defaultRadius))),
                      )),
                ),
                Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 10, bottom: 3, top: 10),
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(defaultRadius),
                              topRight: Radius.circular(defaultRadius),
                              bottomLeft: Radius.circular(taperRadius),
                              bottomRight: Radius.circular(defaultRadius))),
                    )),
                Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, bottom: 3),
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(taperRadius),
                              topRight: Radius.circular(defaultRadius),
                              bottomLeft: Radius.circular(taperRadius),
                              bottomRight: Radius.circular(defaultRadius))),
                    )),
                Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                        bottom: 3,
                      ),
                      height: 50,
                      width: 230,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(taperRadius),
                              topRight: Radius.circular(defaultRadius),
                              bottomLeft: Radius.circular(defaultRadius),
                              bottomRight: Radius.circular(defaultRadius))),
                    )),
              ],
            ),
            Positioned(
              top: 0,
              child: Container(
                color: AppColor.primaryColor,
                width: Get.width,
                child: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    const ShimmerSkelton(
                                        height: 40, width: 40, isCircle: true),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ShimmerSkelton(
                                            height: 18,
                                            width: 150,
                                            borderRadius: 10,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          ShimmerSkelton(height: 5, width: 60),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Icon(
                                Icons.more_vert_rounded,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      const Line()
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                width: Get.width,
                child: Container(
                  height: 58,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 3,
                        color: AppColor.shadowColor,
                      )
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.emoji_emotions_outlined,
                            ),
                            SizedBox(width: 17),
                            Text(
                              "Ketikkan Pesan",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                      Icon(
                        Icons.camera_alt_outlined,
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
