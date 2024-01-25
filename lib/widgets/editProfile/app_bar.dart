import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_font.dart';
import '../global/line.dart';

class AppBarEditProfile extends StatelessWidget {
  const AppBarEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: Container(
        color: Colors.white,
        width: Get.width,
        height: 93,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: const SizedBox(
                          width: 28,
                          child: Icon(Icons.arrow_back, size: 28),
                        ),
                      ),
                      Text("edit_profile".tr,
                          style: AppFont.text20
                              .copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 30)
                    ],
                  ),
                ),
              ),
              const Line(),
            ],
          ),
        ),
      ),
    );
  }
}
