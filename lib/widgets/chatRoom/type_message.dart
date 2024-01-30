import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/chat_room_controller.dart';
import 'package:upmatev2/controllers/gallery_controller.dart';

import '../../themes/app_color.dart';
import '../../themes/app_font.dart';
import '../global/bottom_sheet.dart';
import '../global/emoji_section.dart';

class ChatRoomTypeMessage extends StatelessWidget {
  const ChatRoomTypeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatRoomController>();
    final galleryController = Get.find<GalleryController>();
    return Positioned(
      bottom: 0,
      width: Get.width,
      child: GetBuilder<ChatRoomController>(
        builder: (_) => Column(
          children: [
            Container(
              constraints: const BoxConstraints(maxHeight: 120),
              margin: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: controller.isShowEmoji.value ? 5 : 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 3,
                      color: AppColor.shadowColor)
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
                              controller: controller.textEditingController,
                              maxLines: null,
                              onChanged: (text) {
                                text.trim().isEmpty
                                    ? controller.isTextFieldEmpty.value = true
                                    : controller.isTextFieldEmpty.value = false;
                                controller.update();
                              },
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: "type_a_message".tr,
                                hintStyle: AppFont.text14.copyWith(
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
                              galleryController.selectedAssetList.clear();
                            }
                            BottomSheetWidget.showGalleryChat(
                                galleryController, controller);
                          },
                          child:
                              const Icon(Icons.camera_alt_outlined, size: 28),
                        )
                      : Obx(
                          () => GestureDetector(
                            onTap: controller.isSendingMessage.value
                                ? () {}
                                : () async {
                                    if (!(controller.imgUrl == null &&
                                        controller.textEditingController.text ==
                                            "")) {
                                      await controller.sendChat();
                                    }
                                  },
                            child: const Icon(Icons.send_rounded, size: 28),
                          ),
                        )
                ],
              ),
            ),
            controller.isShowEmoji.value
                ? EmojiSection(controller: controller)
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
