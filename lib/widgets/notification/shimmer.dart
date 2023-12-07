import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/widgets/global/line.dart';
import 'package:upmatev2/widgets/global/skelton.dart';

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 110,
              ),
              const ShimmerSkelton(height: 15, width: 70),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: Column(
                      children: List.generate(
                4,
                (index) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  color: Colors.white,
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
                              height: 50,
                              width: 50,
                              isCircle: true,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ShimmerSkelton(height: 15, width: 150),
                                  SizedBox(
                                    height: 5,
                                  ),
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
              )))
            ],
          ),
        ),
        Positioned(
          top: 0,
          child: Container(
            color: Colors.white,
            width: Get.width,
            child: const SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Notification",
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.more_vert_rounded,
                          size: 28,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                  Line()
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
