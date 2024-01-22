import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/profile_controller.dart';
import 'package:upmatev2/controllers/start_controller.dart';

import '../../routes/route_name.dart';
import '../../themes/app_color.dart';
import '../../themes/app_font.dart';

class DescriptionProfile extends StatelessWidget {
  const DescriptionProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final startController = Get.find<StartController>();
    return GetBuilder<ProfileController>(
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SizedBox(
          height: controller.isFullText.value ? 230 : 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.otherUser.displayName,
                    maxLines: 1,
                    style: AppFont.text16.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    controller.otherUser.username,
                    maxLines: 1,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  RichText(
                    text: TextSpan(style: AppFont.text14, children: [
                      TextSpan(
                        text: controller.handleText(controller.text),
                      ),
                      controller.text.length > 80
                          ? WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: GestureDetector(
                                onTap: () {
                                  controller.isFullText.toggle();
                                  controller.update();
                                },
                                child: Text(
                                  controller.isFullText.value ? "" : "more".tr,
                                  style: AppFont.text14
                                      .copyWith(color: Colors.grey),
                                ),
                              ),
                            )
                          : const WidgetSpan(child: SizedBox()),
                    ]),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: AppColor.lightGrey,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: RichText(
                              text: TextSpan(style: AppFont.text14, children: [
                                TextSpan(
                                  text: "${"following".tr}  ",
                                ),
                                const TextSpan(
                                    text: "5",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ]),
                            ),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: AppColor.lightGrey,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: RichText(
                              text: TextSpan(style: AppFont.text14, children: [
                                TextSpan(
                                  text: "${"followers".tr}  ",
                                ),
                                const TextSpan(
                                    text: "5",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ]),
                            ),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.lightGrey,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            onPressed: () {},
                            child: const Icon(
                              Icons.person_add,
                              size: 20,
                              color: Colors.black,
                            )),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      height: 35,
                      child: ElevatedButton(
                          onPressed: controller.otherUser.uid ==
                                  startController.user!.uid
                              ? () => Get.toNamed(RouteName.editProfile)
                              : () {},
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          child: Center(
                            child: Text(
                              controller.otherUser.uid ==
                                      startController.user!.uid
                                  ? "edit_profile".tr
                                  : "follow".tr,
                              style: AppFont.text14.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
