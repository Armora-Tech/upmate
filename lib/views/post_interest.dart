import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/post_controller.dart';
import 'package:upmatev2/themes/app_color.dart';
import '../themes/app_font.dart';
import '../widgets/global/line.dart';

class PostInterestView extends StatelessWidget {
  const PostInterestView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PostController>();
    return WillPopScope(
        onWillPop: () async {
          controller.selectedTags.clear();
          Get.back();
          return Future.value(false);
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
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
                                  onTap: () {
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
                                  onTap: () {
                                    controller.addPost();
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Tag Interest",
                            style: AppFont.text28
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                              "Pilihlah tag interest yang sesuai untuk postingan Anda",
                              overflow: TextOverflow.visible,
                              style: AppFont.text14),
                          const SizedBox(
                            height: 40,
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
                                            .contains(controller.tags[index]);
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
                                                      controller.tags[index],
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
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
