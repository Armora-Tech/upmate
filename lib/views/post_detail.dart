import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/home_controller.dart';
import 'package:upmatev2/controllers/post_detail_controller.dart';
import 'package:upmatev2/themes/app_font.dart';
import 'package:upmatev2/widgets/global/emoji_section.dart';
import 'package:upmatev2/widgets/global/profile_picture.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';
import '../themes/app_color.dart';
import '../widgets/global/line.dart';
import '../widgets/global/post_image.dart';

class PostDetailView extends StatelessWidget {
  const PostDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final controller = Get.find<PostDetailController>();
    controller.selectedIndex = homeController.selectedIndex;
    int index = controller.selectedIndex.value;
    final PostModel post = homeController.posts![index];
    final UserModel userPost = homeController.posts![index].user!;
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          if (controller.isShowEmoji.value) {
            controller.isShowEmoji.value = false;
          } else {
            Get.back();
          }
          return Future.value(false);
        },
        child: Stack(fit: StackFit.expand, children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        margin: const EdgeInsets.only(right: 10),
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Image.network(
                          FirebaseAuth.instance.currentUser!.photoURL!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              homeController.posts![index].user!.displayName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              homeController.usernameWithAt(index),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                PostImage(controller: homeController, index: index),
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
                                onTap: () async {},
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
                                  text: TextSpan(
                                      style: AppFont.text14,
                                      children: [
                                        TextSpan(
                                            text:
                                                "${userPost.displayName.replaceAll(" ", "").toLowerCase()}  ",
                                            style: AppFont.text14.copyWith(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                          text: homeController
                                              .handleText(post.postDescription),
                                        ),
                                        post.postDescription.length > 80
                                            ? WidgetSpan(
                                                alignment:
                                                    PlaceholderAlignment.middle,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    homeController.isFullText
                                                        .toggle();
                                                  },
                                                  child: Text(
                                                    homeController
                                                            .isFullText.value
                                                        ? " ${"less".tr}"
                                                        : "more".tr,
                                                    style: AppFont.text12
                                                        .copyWith(
                                                            color: Colors.grey),
                                                  ),
                                                ),
                                              )
                                            : const WidgetSpan(
                                                child: SizedBox()),
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
                                      style:
                                          const TextStyle(color: Colors.grey)),
                                  Row(
                                    children: [
                                      Container(
                                        width: 25,
                                        margin:
                                            const EdgeInsets.only(right: 10),
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
                                        margin:
                                            const EdgeInsets.only(right: 10),
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
                        Text(
                          homeController.postingTimePassed(index),
                          style: AppFont.text12.copyWith(color: Colors.grey),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 150,
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              color: Colors.white,
              width: Get.width,
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: const SizedBox(
                              width: 30,
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            "Post",
                            style: AppFont.text20.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          )
                        ],
                      ),
                    ),
                    const Line(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              width: Get.width,
              child: Obx(
                () => Column(
                  children: [
                    Container(
                      constraints: const BoxConstraints(maxHeight: 140),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15)),
                        color: AppColor.primaryColor,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            topRight: Radius.circular(40),
                                            bottomLeft: Radius.circular(40),
                                            bottomRight: Radius.circular(8)),
                                        color: AppColor.primaryColor),
                                    child: const ProfilePicture(size: 30),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: TextField(
                                        focusNode: controller.focusNode,
                                        style: AppFont.text16,
                                        controller:
                                            controller.textEditingController,
                                        maxLines: null,
                                        onChanged: (text) {
                                          text.isNotEmpty
                                              ? controller.isTextFieldEmpty
                                                  .value = false
                                              : controller.isTextFieldEmpty
                                                  .value = true;
                                        },
                                        decoration: InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          hintText: "type_a_message".tr,
                                          hintStyle: AppFont.text14.copyWith(
                                            color: Colors.grey,
                                            fontFamily: "Nunito",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.isShowEmoji.toggle();
                                    controller.focusNode.unfocus();
                                  },
                                  child: Icon(
                                    controller.isShowEmoji.value
                                        ? Icons.emoji_emotions_rounded
                                        : Icons.emoji_emotions_outlined,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                controller.isTextFieldEmpty.value
                                    ? const Icon(
                                        Icons.camera_alt_outlined,
                                        size: 28,
                                      )
                                    : const Icon(
                                        Icons.send_rounded,
                                        size: 28,
                                      ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    controller.isShowEmoji.value
                        ? EmojiSection(controller: controller)
                        : const SizedBox.shrink()
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}
