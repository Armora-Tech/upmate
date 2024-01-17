import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/home_controller.dart';
import 'package:upmatev2/controllers/post_controller.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/widgets/global/dialog_interest.dart';
import '../../themes/app_font.dart';
import '../../widgets/global/blur_loading.dart';
import '../../widgets/global/line.dart';

class PostInterestView extends StatelessWidget {
  const PostInterestView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PostController>();
    final homeController = Get.find<HomeController>();
    return WillPopScope(
        onWillPop: () async {
          controller.selectedTags.clear();
          Get.back();
          return Future.value(false);
        },
        child: Scaffold(
          body: SizedBox(
            height: Get.height,
            width: Get.width,
            child: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "tag_interest".tr,
                            style: AppFont.text28
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                              "choose_the_appropriate_interest_tag_for_your_post"
                                  .tr,
                              overflow: TextOverflow.visible,
                              style: AppFont.text14),
                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Wrap(
                              runSpacing: 20,
                              spacing: 20,
                              runAlignment: WrapAlignment.center,
                              direction: Axis.horizontal,
                              children: List.generate(
                                  controller.tags.length,
                                  (index) =>
                                      GetBuilder<PostController>(builder: (_) {
                                        bool isSelectedTags = controller
                                            .selectedTags
                                            .contains(controller.tags.values
                                                .elementAt(index));
                                        return Material(
                                          clipBehavior: Clip.hardEdge,
                                          elevation: 0,
                                          color: isSelectedTags
                                              ? AppColor.primaryColor
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: InkWell(
                                            onTap: () => controller
                                                .toggleInterest(index),
                                            child: Container(
                                              width: Get.width / 2 - 30,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: isSelectedTags
                                                          ? AppColor
                                                              .primaryColor
                                                          : AppColor
                                                              .lightGrey)),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "#",
                                                    overflow:
                                                        TextOverflow.visible,
                                                    style: AppFont.text12
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                isSelectedTags
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black),
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      controller.tags.keys
                                                          .elementAt(index),
                                                      overflow:
                                                          TextOverflow.visible,
                                                      style: AppFont.text12
                                                          .copyWith(
                                                              color:
                                                                  isSelectedTags
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      })),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                              "type_your_interest_if_there_is_no_tag_you_are_interested_in"
                                  .tr,
                              overflow: TextOverflow.visible,
                              style: AppFont.text14),
                          const SizedBox(
                            height: 10,
                          ),
                          Material(
                              clipBehavior: Clip.hardEdge,
                              elevation: 0,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: controller.isLoading.value
                                    ? () {}
                                    : () =>
                                        DialogInterest.showPopup(controller),
                                child: IntrinsicWidth(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 1,
                                            color: AppColor.lightGrey)),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "add_your_tag_interest".tr,
                                              overflow: TextOverflow.visible,
                                              style: AppFont.text12.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Icon(
                                            Icons.add,
                                            size: 15,
                                          ),
                                        ]),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      color: Colors.white,
                      width: Get.width,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 13),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: controller.isLoading.value
                                      ? () {}
                                      : () {
                                          controller.selectedTags.clear();
                                          Get.back();
                                        },
                                  child: const Icon(
                                    Icons.arrow_back,
                                    size: 25,
                                    color: Colors.black,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: controller.isLoading.value
                                      ? () {}
                                      : () async {
                                          await controller.addPost();
                                          await homeController.refreshPosts();
                                        },
                                  child: Text(
                                    "Post",
                                    style: AppFont.text16.copyWith(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Line()
                        ],
                      ),
                    ),
                  ),
                  Obx(() => controller.isLoading.value
                      ? const BlurLoading()
                      : const SizedBox())
                ],
              ),
            ),
          ),
        ));
  }
}
