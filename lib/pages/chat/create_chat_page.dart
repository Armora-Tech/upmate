import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/chat_controller.dart';
import 'package:upmatev2/widgets/global/search_template.dart';
import 'package:upmatev2/widgets/global/user_list.dart';

import '../../widgets/global/blur_loading.dart';

class CreateChatView extends StatelessWidget {
  const CreateChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();
    return GetBuilder<ChatController>(
      builder: (_) => WillPopScope(
        onWillPop: () async {
          if (!controller.isLoading.value) {
            controller.back();
            Get.back();
          }
          return Future.value(false);
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            SearchTemplate(
              title: "create_a_new_chat".tr,
              controller: controller,
              child: UserList(
                  selectedPage: SearchPage.createChatPage,
                  controller: controller),
            ),
            Obx(() => controller.isLoading.value
                ? const BlurLoading()
                : const SizedBox())
          ],
        ),
      ),
    );
  }
}
