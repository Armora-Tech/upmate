import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_color.dart';

class Line extends StatelessWidget {
  const Line({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height: 0.5, width: Get.width, color: AppColor.lightGrey);
  }
}
