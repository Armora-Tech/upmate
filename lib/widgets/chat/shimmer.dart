import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upmatev2/widgets/global/line.dart';
import 'package:upmatev2/widgets/global/skelton.dart';

import '../../themes/app_color.dart';
import '../../themes/app_font.dart';

class ChatShimmer extends StatelessWidget {
  const ChatShimmer({super.key});

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
              const SizedBox(height: 110),
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
          Positioned(
            top: 0,
            child: Container(
              color: Colors.white,
              width: Get.width,
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("chat".tr,
                              style: AppFont.text23
                                  .copyWith(fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svg/search.svg",
                                colorFilter: const ColorFilter.mode(
                                    AppColor.black, BlendMode.srcIn),
                              ),
                              const SizedBox(width: 20),
                              SvgPicture.asset("assets/svg/more_vert.svg",
                                  height: 22),
                            ],
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
        ],
      ),
    );
  }
}
