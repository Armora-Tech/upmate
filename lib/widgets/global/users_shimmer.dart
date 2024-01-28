import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/widgets/global/skelton.dart';

class UsersShimmer extends StatelessWidget {
  const UsersShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Expanded(
                child: Column(
                  children: List.generate(
                    4,
                    (index) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: Get.width,
                      height: 50,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ShimmerSkelton(
                                    height: 50, width: 50, isCircle: true),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ShimmerSkelton(height: 15, width: 150),
                                      SizedBox(height: 5),
                                      ShimmerSkelton(height: 8, width: 70),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
