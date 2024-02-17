import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/profile_controller.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/models/user_model.dart';

import '../../routes/route_name.dart';
import '../../themes/app_color.dart';
import '../../themes/app_font.dart';

class DescriptionProfile extends StatelessWidget {
  final UserModel user;
  const DescriptionProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final startController = Get.find<StartController>();
    return GetBuilder<ProfileController>(
      builder: (_) => SizedBox(
        height: controller.isFullText.value
            ? 245
            : (user.bio == null || user.bio == "")
                ? 140
                : 185,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.displayName,
                          maxLines: 1,
                          style: AppFont.text16
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text(user.username,
                          maxLines: 1,
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Transform.translate(
                      offset: const Offset(0, -40),
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: Get.width * 0.6,
                        child: RichText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: AppFont.text12,
                            children: user.interests
                                .map<InlineSpan>(
                                  (interest) => TextSpan(
                                    text: "#$interest ",
                                    style: AppFont.text14
                                        .copyWith(color: Colors.grey),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (user.bio == null || user.bio == "")
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 15),
                            child: RichText(
                              text: TextSpan(
                                style: AppFont.text14,
                                children: [
                                  TextSpan(
                                      text: controller
                                          .handleText(user.bio ?? "")),
                                  user.bio != null &&
                                          user.bio!.length >
                                              controller
                                                  .highlightDescLength.value
                                      ? WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.isFullText.toggle();
                                              controller.update();
                                            },
                                            child: Text(
                                                controller.isFullText.value
                                                    ? ""
                                                    : "more".tr,
                                                style: AppFont.text14.copyWith(
                                                    color: Colors.grey)),
                                          ),
                                        )
                                      : const WidgetSpan(child: SizedBox()),
                                ],
                              ),
                            ),
                          ),
                    const Spacer(),
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
                              text: TextSpan(
                                style: AppFont.text14,
                                children: [
                                  TextSpan(text: "${"following".tr}  "),
                                  const TextSpan(
                                      text: "5",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: AppColor.lightGrey,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                style: AppFont.text14,
                                children: [
                                  TextSpan(text: "${"followers".tr}  "),
                                  const TextSpan(
                                      text: "5",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
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
                            child: const Icon(Icons.person_add,
                                size: 20, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 35,
                      child: ElevatedButton(
                        onPressed: user.uid == startController.user!.uid
                            ? () => Get.toNamed(RouteName.editProfile)
                            : () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        child: Center(
                          child: Text(
                            user.uid == startController.user!.uid
                                ? "edit_profile".tr
                                : "follow".tr,
                            style: AppFont.text14.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
