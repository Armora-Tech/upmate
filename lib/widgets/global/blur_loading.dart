import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:upmatev2/themes/app_font.dart';

class BlurLoading extends StatelessWidget {
  const BlurLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.black.withOpacity(0.4),
          child: Center(
            child: Container(
              height: 220,
              width: 220,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LoadingAnimationWidget.stretchedDots(
                      size: 70, color: Colors.white),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Loading",
                    style: AppFont.text16.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
