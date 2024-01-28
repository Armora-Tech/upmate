import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/widgets/chat/app_bar.dart';
import 'package:upmatev2/widgets/chat/chat_list.dart';

import '../controllers/chat_controller.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();
    return Stack(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [SizedBox(height: 80), Expanded(child: ChatList())],
        ),
        Positioned(
          bottom: 80,
          right: 20,
          child: GetBuilder<ChatController>(
            builder: (_) => FloatingActionButton(
              onPressed: controller.isLoading.value
                  ? () {}
                  : () => Get.toNamed(RouteName.createChat),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ),
        const ChatViewAppBar()
      ],
    );
  }
}
