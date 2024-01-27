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
        GetBuilder<ChatController>(
          builder: (_) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: controller.isShowSearch.value ? 140 : 80),
              const Expanded(child: ChatList())
            ],
          ),
        ),
        Positioned(
          bottom: 80,
          right: 20,
          child: FloatingActionButton(
            onPressed: () => Get.toNamed(RouteName.addChat),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
        const ChatViewAppBar()
      ],
    );
  }
}
