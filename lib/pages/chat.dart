import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/widgets/chat/app_bar.dart';
import 'package:upmatev2/widgets/chat/chat_list.dart';
import 'package:upmatev2/widgets/chat/shimmer.dart';

import '../controllers/chat_controller.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());
    controller.loading();
    return Obx(
      () => controller.isLoading.value
          ? const ChatShimmer()
          : Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: controller.isShowSearch.value ? 140 : 80),
                    Expanded(child: ChatList())
                  ],
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
            ),
    );
  }
}
