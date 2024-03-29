import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_color.dart';
import 'cached_network_image.dart';

class MyBanner extends StatelessWidget {
  final String? bannerUrl;
  const MyBanner({super.key, this.bannerUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width * 9 / 16,
      width: Get.width,
      decoration: const BoxDecoration(color: AppColor.primaryColor),
      child: bannerUrl == null
          ? const SizedBox()
          : CachedNetworkImageWidget(
              imageUrl: bannerUrl!,
              circularProgressSize: 20,
              heightPlaceHolder: Get.width * 9 / 16,
              widthPlaceHolder: Get.width,
              radiusPlaceHolder: 0,
              fit: BoxFit.cover),
    );
  }
}
