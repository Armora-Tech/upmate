import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upmatev2/widgets/global/skelton.dart';

import '../../controllers/home_controller.dart';
import '../../routes/route_name.dart';
import '../../themes/app_font.dart';
import 'post_image.dart';

class PostContent extends StatelessWidget {
  final int index;
  const PostContent({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        controller.isLoading.value
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ShimmerSkelton(
                  height: Get.width,
                  width: Get.width,
                  borderRadius: 0,
                ),
              )
            : PostImage(index: index),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () async {},
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  "assets/svg/favorite_outlined.svg",
                                  semanticsLabel: 'favorite'),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "${controller.isLoading.value ? 0 : controller.posts![index].likes.length}",
                                style: AppFont.text10,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: controller.isLoading.value
                            ? () {}
                            : () {
                                controller.selectedIndex.value = index;
                                Get.toNamed(
                                  RouteName.postDetail,
                                );
                              },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/svg/comment.svg",
                                  semanticsLabel: 'comment'),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "${controller.isLoading.value ? 0 : controller.posts![index].comments?.length}",
                                style: AppFont.text10,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {},
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  "assets/svg/bookmark_outlined.svg",
                                  semanticsLabel: 'bookmark'),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "${controller.isLoading.value ? 0 : controller.posts![index].bookmarks.length}",
                                style: AppFont.text10,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {},
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/svg/share.svg",
                                  height: 26, semanticsLabel: 'share'),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "${controller.isLoading.value ? 0 : 0}",
                                style: AppFont.text10,
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
                const SizedBox(
                  height: 15,
                ),
                controller.isLoading.value
                    ? const ShimmerSkelton(height: 10, width: 80)
                    : controller.posts![index].postDescription.isEmpty
                        ? const SizedBox()
                        : Obx(() => RichText(
                              text: TextSpan(style: AppFont.text14, children: [
                                TextSpan(
                                    text:
                                        "${controller.posts![index].user!.displayName.replaceAll(" ", "").toLowerCase()}  ",
                                    style: AppFont.text14
                                        .copyWith(fontWeight: FontWeight.bold)),
                                TextSpan(
                                  text: controller.handleText(
                                      controller.posts![index].postDescription),
                                ),
                                controller.posts![index].postDescription
                                            .length >
                                        80
                                    ? WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.isFullText.toggle();
                                          },
                                          child: Text(
                                            controller.isFullText.value
                                                ? " ${"less".tr}"
                                                : "more".tr,
                                            style: AppFont.text12
                                                .copyWith(color: Colors.grey),
                                          ),
                                        ),
                                      )
                                    : const WidgetSpan(child: SizedBox()),
                              ]),
                            )),
                const SizedBox(
                  height: 5,
                ),
                controller.isLoading.value
                    ? const SizedBox()
                    : controller.posts![index].comments!.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${"see_all".tr} 32 ${"comment".tr}",
                                  style: const TextStyle(color: Colors.grey)),
                              Row(
                                children: [
                                  Container(
                                    width: 25,
                                    margin: const EdgeInsets.only(right: 10),
                                    clipBehavior: Clip.hardEdge,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle),
                                    child: Image.network(
                                      "https://i.pinimg.com/736x/e5/93/09/e593098f04ed9c1f5fa05749ff0aff26.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                              style: AppFont.text14,
                                              children: const [
                                                TextSpan(
                                                  text: "Flora Shafiqa ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "Keren banget kak (emot api)",
                                                ),
                                              ]),
                                        ),
                                        Text(
                                          "2 ${"hours".tr}",
                                          maxLines: 2,
                                          style: AppFont.text10
                                              .copyWith(color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 25,
                                    margin: const EdgeInsets.only(right: 10),
                                    clipBehavior: Clip.hardEdge,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle),
                                    child: Image.network(
                                      "https://i.pinimg.com/736x/e5/93/09/e593098f04ed9c1f5fa05749ff0aff26.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                              style: AppFont.text14,
                                              children: const [
                                                TextSpan(
                                                  text: "Flora Shafiqa ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "Not bad...(emot keren)",
                                                ),
                                              ]),
                                        ),
                                        Text(
                                          "2 ${"hours".tr}",
                                          maxLines: 2,
                                          style: AppFont.text10
                                              .copyWith(color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : const SizedBox(),
                controller.isLoading.value
                    ? const ShimmerSkelton(height: 10, width: 60)
                    : Text(
                        controller.postingTimePassed(index),
                        style: AppFont.text12.copyWith(color: Colors.grey),
                      ),
              ],
            )),
      ],
    );
  }
}
