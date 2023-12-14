import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:upmatev2/controllers/chat_room_controller.dart';
import 'package:upmatev2/controllers/gallery_controller.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/themes/app_font.dart';
import 'package:upmatev2/widgets/chatRoom/shimmer.dart';
import 'package:upmatev2/widgets/global/profile_picture.dart';
import '../utils/bottom_sheet.dart';
import '../widgets/global/detail_image.dart';
import '../widgets/global/emoji_section.dart';
import '../widgets/global/line.dart';

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatRoomController>();
    final galleryController = Get.find<GalleryController>();
    return GetBuilder<ChatRoomController>(
        builder: (_) => controller.isLoading.value
            ? const Scaffold(
                body: ChatRoomShimmer(),
              )
            : Scaffold(
                body: WillPopScope(
                  onWillPop: () {
                    if (controller.isShowEmoji.value) {
                      controller.isShowEmoji.value = false;
                    } else {
                      Get.back();
                    }
                    controller.update();
                    return Future.value(false);
                  },
                  child: SizedBox(
                    height: Get.height,
                    child: Stack(children: [
                      ListView.separated(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 120, bottom: 100),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        itemCount: controller.chats.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 2,
                          );
                        },
                        itemBuilder: (context, index) {
                          final reversedIndex =
                              controller.chats.length - 1 - index;
                          controller.setMargin(reversedIndex);
                          return SizedBox(
                            width: Get.width,
                            child: Column(
                              crossAxisAlignment:
                                  controller.isUser(reversedIndex)
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: controller.marginTop.value,
                                      bottom: controller.marginBottom.value),
                                  child: IntrinsicWidth(
                                    child: Container(
                                      constraints: BoxConstraints(
                                          maxWidth: Get.width * 0.7),
                                      alignment:
                                          controller.isUser(reversedIndex)
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 7),
                                      decoration: BoxDecoration(
                                          color:
                                              controller.isUser(reversedIndex)
                                                  ? Colors.white
                                                  : AppColor.primaryColor,
                                          border: controller
                                                  .isUser(reversedIndex)
                                              ? Border.all(
                                                  width: 1,
                                                  color: const Color.fromARGB(
                                                      255, 144, 172, 183))
                                              : Border.all(width: 0),
                                          borderRadius: controller
                                              .checkPositionedUserChat(
                                                  reversedIndex)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (controller.chats[reversedIndex]
                                              .values.first is File)
                                            GestureDetector(
                                              onTap: () => Get.to(
                                                  () => DetailImage(
                                                        image: controller
                                                            .chats[
                                                                reversedIndex]
                                                            .values
                                                            .first,
                                                      ),
                                                  opaque: false,
                                                  fullscreenDialog: true,
                                                  transition:
                                                      Transition.noTransition),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 3),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Hero(
                                                    tag: controller
                                                        .chats[reversedIndex]
                                                        .values
                                                        .first
                                                        .toString(),
                                                    child: Image.file(
                                                      controller
                                                          .chats[reversedIndex]
                                                          .values
                                                          .first,
                                                      gaplessPlayback: true,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          else if (controller
                                              .chats[reversedIndex]
                                              .values
                                              .first is AssetEntity)
                                            GestureDetector(
                                              onTap: () => Get.to(
                                                  () => DetailImage(
                                                        image: controller
                                                            .chats[
                                                                reversedIndex]
                                                            .values
                                                            .first,
                                                      ),
                                                  opaque: false,
                                                  fullscreenDialog: true,
                                                  transition:
                                                      Transition.noTransition),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 3),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Hero(
                                                      tag: controller
                                                          .chats[reversedIndex]
                                                          .values
                                                          .first
                                                          .toString(),
                                                      child: AssetEntityImage(
                                                        controller
                                                            .chats[
                                                                reversedIndex]
                                                            .values
                                                            .first,
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                              ),
                                            )
                                          else
                                            Text(
                                              controller.chats[reversedIndex]
                                                  .values.first,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  color: controller
                                                          .isUser(reversedIndex)
                                                      ? Colors.black
                                                      : Colors.white),
                                            ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "09.00",
                                                style: AppFont.text10
                                                    .copyWith(
                                                        color: Colors.grey),
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              const Icon(
                                                Icons.check_rounded,
                                                color: Colors.grey,
                                                size: 16,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Positioned(
                        top: 0,
                        child: Container(
                          color: AppColor.primaryColor,
                          width: Get.width,
                          child: SafeArea(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 13, vertical: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () => Get.back(),
                                              child: const Icon(
                                                Icons.arrow_back,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            const ProfilePicture(size: 40),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Muhammad Rafli Silehu",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "Online",
                                                    style: AppFont
                                                        .text12
                                                        .copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Icon(
                                          Icons.more_vert_rounded,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Line()
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        width: Get.width,
                        child: Column(
                          children: [
                            Container(
                              constraints: const BoxConstraints(maxHeight: 120),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical:
                                      controller.isShowEmoji.value ? 5 : 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    color: AppColor.shadowColor,
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            controller.isShowEmoji.toggle();
                                            controller.focusNode.unfocus();
                                            controller.update();
                                          },
                                          child: Icon(
                                            controller.isShowEmoji.value
                                                ? Icons.emoji_emotions_rounded
                                                : Icons.emoji_emotions_outlined,
                                          ),
                                        ),
                                        const SizedBox(width: 2),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: TextField(
                                              focusNode: controller.focusNode,
                                              style: AppFont.text16,
                                              controller: controller
                                                  .textEditingController,
                                              maxLines: null,
                                              onChanged: (text) {
                                                text.isEmpty
                                                    ? controller
                                                        .isTextFieldEmpty
                                                        .value = true
                                                    : controller
                                                        .isTextFieldEmpty
                                                        .value = false;
                                                controller.update();
                                              },
                                              decoration: InputDecoration(
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                hintText: "Ketikkan Pesan",
                                                hintStyle: AppFont.text14
                                                    .copyWith(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  controller.isTextFieldEmpty.value
                                      ? GestureDetector(
                                          onTap: () {
                                            if (!Get.isBottomSheetOpen!) {
                                              galleryController
                                                  .selectedAssetList
                                                  .clear();
                                            }
                                            BottomSheetUtil.showGalleryChat(
                                                galleryController, controller);
                                          },
                                          child: const Icon(
                                            Icons.camera_alt_outlined,
                                            size: 28,
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () => controller.sendChat(),
                                          child: const Icon(
                                            Icons.send_rounded,
                                            size: 28,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            controller.isShowEmoji.value
                                ? EmojiSection(controller: controller)
                                : const SizedBox.shrink()
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ));
  }
}
