import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/chat_controller.dart';
import 'package:upmatev2/widgets/global/search_template.dart';
import 'package:upmatev2/widgets/global/user_list.dart';

class CreateChatView extends StatelessWidget {
  const CreateChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();
    return WillPopScope(
      onWillPop: () async {
        controller.back();
        Get.back();
        return Future.value(false);
      },
      child: GetBuilder<ChatController>(
        builder: (_) => SearchTemplate(
          title: "create_a_new_chat".tr,
          controller: controller,
          child: UserList(
              selectedPage: SearchPage.createChatPage, controller: controller),
        ),
      ),
    );
  }
}
