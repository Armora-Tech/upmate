import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/chat_controller.dart';
import 'package:upmatev2/routes/route_name.dart';

import '../../controllers/start_controller.dart';
import '../../themes/app_color.dart';
import '../../themes/app_font.dart';
import '../global/line.dart';

class ChatViewAppBar extends StatelessWidget {
  const ChatViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();
    final startController = Get.find<StartController>();
    return Positioned(
      top: 0,
      child: SafeArea(
        child: SizedBox(
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("chat".tr,
                            style: AppFont.text23
                                .copyWith(fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Obx(
                              () => GestureDetector(
                                onTap: startController.isLoading.value &&
                                        controller.isLoading.value
                                    ? () {}
                                    : () => Get.toNamed(RouteName.searchChat),
                                child: SvgPicture.asset(
                                  "assets/svg/search.svg",
                                  colorFilter: const ColorFilter.mode(
                                      AppColor.black, BlendMode.srcIn),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            SvgPicture.asset("assets/svg/more_vert.svg",
                                height: 22),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Align(alignment: Alignment.bottomCenter, child: Line())
            ],
          ),
        ),
      ),
    );
  }
}
