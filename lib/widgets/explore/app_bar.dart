import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upmatev2/themes/app_font.dart';

import '../../routes/route_name.dart';
import '../../themes/app_color.dart';

class ExploreAppBar extends StatelessWidget {
  const ExploreAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: Container(
        color: Colors.white,
        width: Get.width,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      backgroundColor: AppColor.bgSearch),
                  onPressed: () => Get.toNamed(RouteName.search),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13.0, vertical: 3),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/search.svg",
                            colorFilter: const ColorFilter.mode(
                                AppColor.black, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 10),
                          Text("search".tr, style: AppFont.text14)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
