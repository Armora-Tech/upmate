import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/chat_room_controller.dart';
import 'package:upmatev2/widgets/chatRoom/chat_section.dart';
import 'package:upmatev2/widgets/chatRoom/shimmer.dart';
import '../../widgets/chatRoom/app_bar.dart';
import '../../widgets/chatRoom/type_message.dart';

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatRoomController>();
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
                  child: const Stack(
                    children: [
                      ChatRoomChatSection(),
                      ChatRoomAppBar(),
                      ChatRoomTypeMessage(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
