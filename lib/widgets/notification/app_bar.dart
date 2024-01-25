import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../themes/app_font.dart';
import '../global/line.dart';

class NotificationAppBar extends StatelessWidget {
  const NotificationAppBar({super.key});

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "notification".tr,
                      style:
                          AppFont.text23.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SvgPicture.asset("assets/svg/more_vert.svg", height: 22),
                  ],
                ),
              ),
              const Line()
            ],
          ),
        ),
      ),
    );
  }
}
