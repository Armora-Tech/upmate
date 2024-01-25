import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:upmatev2/widgets/global/line.dart';

import '../../controllers/observer/action_post_controller.dart';
import '../../themes/app_font.dart';
import '../global/skelton.dart';

class ShimmerPostSection extends StatelessWidget {
  const ShimmerPostSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: Row(
                  children: [
                    ShimmerSkelton(
                        height: 35, width: 35, isCircle: true, borderRadius: 0),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerSkelton(height: 10, width: 120),
                          SizedBox(height: 5),
                          ShimmerSkelton(height: 10, width: 100)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset("assets/svg/more_vert.svg", height: 22)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ShimmerSkelton(
              height: Get.width, width: Get.width, borderRadius: 0),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5), 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/svg/favorite_outlined.svg",
                        semanticsLabel: 'favorite', height: 27, width: 27),
                    const SizedBox(height: 2),
                    Text("0", style: AppFont.text10)
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/svg/comment.svg",
                        height: 27, width: 27, semanticsLabel: 'comment'),
                    const SizedBox(height: 2),
                    Text("0", style: AppFont.text10)
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: GetBuilder<ActionPostController>(
                  builder: (_) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/svg/bookmark_outlined.svg",
                          height: 27, width: 27, semanticsLabel: 'bookmark'),
                      const SizedBox(height: 2),
                      Text("0", style: AppFont.text10)
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/svg/share.svg",
                        height: 27, width: 27, semanticsLabel: 'share'),
                    const SizedBox(height: 2),
                    Text("0", style: AppFont.text10)
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerSkelton(height: 10, width: 80),
                SizedBox(height: 5),
                ShimmerSkelton(height: 10, width: 60),
                SizedBox(height: 10),
              ],
            )),
        const Line(),
      ],
    );
  }
}
