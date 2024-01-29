import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/chat_controller.dart';
import 'package:upmatev2/widgets/global/search_template.dart';
import 'package:upmatev2/widgets/global/user_list.dart';

import '../../widgets/global/users_shimmer.dart';

class SearchChatView extends StatelessWidget {
  const SearchChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        controller.back();
        return Future.value(false);
      },
      child: GetBuilder<ChatController>(
        builder: (_) => SearchTemplate(
          title: "search".tr,
          controller: controller,
          child: controller.isLoading.value
              ? const UsersShimmer()
              : UserList(
                  selectedPage: SearchPage.searchChatPage,
                  controller: controller),
        ),
      ),
    );
  }
}
