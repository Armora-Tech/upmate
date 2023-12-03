import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/chat_room_controller.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/widgets/global/profile_picture.dart';
import '../widgets/global/emoji_section.dart';
import '../widgets/global/line.dart';

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatRoomController>();
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
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 90,
                ),
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: controller.chats.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 2,
                      );
                    },
                    itemBuilder: (context, index) {
                      controller.setMargin(index);
                      return SizedBox(
                        width: Get.width,
                        child: Column(
                          crossAxisAlignment: controller.isUser(index)
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: controller.marginTop.value,
                                  bottom: controller.marginBottom.value),
                              child: IntrinsicWidth(
                                child: Container(
                                  constraints:
                                      BoxConstraints(maxWidth: Get.width * 0.7),
                                  margin: index == controller.chats.length - 1
                                      ? const EdgeInsets.only(bottom: 100)
                                      : EdgeInsets.zero,
                                  alignment: controller.isUser(index)
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 7),
                                  decoration: BoxDecoration(
                                      color: controller.isUser(index)
                                          ? Colors.white
                                          : AppColor.primaryColor,
                                      border: controller.isUser(index)
                                          ? Border.all(
                                              width: 1,
                                              color: const Color.fromARGB(
                                                  255, 144, 172, 183))
                                          : Border.all(width: 0),
                                      borderRadius: controller
                                          .checkPositionedUserChat(index)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.chats[index].values.first,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            color: controller.isUser(index)
                                                ? Colors.black
                                                : Colors.white),
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "09.00",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Icon(
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
                ),
              ],
            ),
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
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Muhammad Rafli Silehu",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "Online",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
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
                              size: 28,
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
            child: Obx(
              () => Column(
                children: [
                  Container(
                    constraints: const BoxConstraints(maxHeight: 120),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
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
                              const SizedBox(width: 2),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: TextField(
                                    focusNode: controller.focusNode,
                                    style: const TextStyle(fontSize: 16),
                                    controller:
                                        controller.textEditingController,
                                    maxLines: null,
                                    onChanged: (text) {
                                      text.isNotEmpty
                                          ? controller.isTextFieldEmpty.value =
                                              false
                                          : controller.isTextFieldEmpty.value =
                                              true;
                                    },
                                    decoration: const InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Ketikkan Pesan",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontFamily: "Nunito",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        controller.isTextFieldEmpty.value
                            ? const Icon(
                                Icons.camera_alt_outlined,
                                size: 28,
                              )
                            : GestureDetector(
                                onTap: () {},
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
          )
        ]),
      ),
    );
  }
}