import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../models/post_model.dart';
import '../../models/user_model.dart';
import '../../routes/route_name.dart';
import '../../themes/app_font.dart';
import 'post_image.dart';

class PostContent extends StatelessWidget {
  final int index;
  const PostContent({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
              final PostModel post = controller.posts![index];
          final UserModel userPost = controller.posts![index].user!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostImage(controller: controller, index: index),
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
                              const Icon(
                                Icons.share_outlined,
                                size: 27,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "0",
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
                              const Icon(
                                Icons.bookmark_outline_rounded,
                                size: 27,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "${post.bookmarks.length}",
                                style: AppFont.text10,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
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
                              const Icon(
                                Icons.chat_bubble_outline_rounded,
                                size: 27,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "${post.comments?.length}",
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
                              const Icon(
                                Icons.favorite_border_rounded,
                                size: 27,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "${post.likes.length}",
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
                post.postDescription.isEmpty
                    ? const SizedBox()
                    : Obx(() => RichText(
                          text: TextSpan(style: AppFont.text14, children: [
                            TextSpan(
                                text:
                                    "${userPost.displayName.replaceAll(" ", "").toLowerCase()}  ",
                                style: AppFont.text14
                                    .copyWith(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: controller.handleText(post.postDescription),
                            ),
                            post.postDescription.length > 80
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
                post.comments!.isNotEmpty
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
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: Image.network(
                                  "https://i.pinimg.com/736x/e5/93/09/e593098f04ed9c1f5fa05749ff0aff26.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          style: AppFont.text14,
                                          children: const [
                                            TextSpan(
                                              text: "Flora Shafiqa ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
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
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: Image.network(
                                  "https://i.pinimg.com/736x/e5/93/09/e593098f04ed9c1f5fa05749ff0aff26.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          style: AppFont.text14,
                                          children: const [
                                            TextSpan(
                                              text: "Flora Shafiqa ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: "Not bad...(emot keren)",
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
                Text(
                  controller.postingTimePassed(index),
                  style: AppFont.text12.copyWith(color: Colors.grey),
                ),
              ],
            )),
      ],
    );
  }
}
