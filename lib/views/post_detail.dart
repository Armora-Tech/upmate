import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/home_controller.dart';
import 'package:upmatev2/controllers/post_detail_controller.dart';
import 'package:upmatev2/themes/app_font.dart';
import 'package:upmatev2/widgets/global/emoji_section.dart';
import 'package:upmatev2/widgets/global/post_section.dart';
import 'package:upmatev2/widgets/global/profile_picture.dart';
import '../themes/app_color.dart';
import '../widgets/global/line.dart';

class PostDetailView extends StatelessWidget {
  const PostDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final controller = Get.find<PostDetailController>();
    controller.selectedIndex = homeController.selectedIndex;
    int index = controller.selectedIndex.value;
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
                        height: 35,
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
                              homeController.posts![index].user!.username,
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
                PostContent(index: index),
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
