import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          color: Colors.black.withOpacity(0.2),
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
              strokeWidth: 2,
            ),
          ),
        ),
      ),
    );
  }
}
