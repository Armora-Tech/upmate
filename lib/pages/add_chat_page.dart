import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/chat_controller.dart';
import 'package:upmatev2/widgets/global/line.dart';
import 'package:upmatev2/widgets/global/search_template.dart';

import '../models/user_model.dart';
import '../routes/route_name.dart';
import '../themes/app_font.dart';
import '../widgets/global/profile_picture.dart';

class AddChatView extends StatelessWidget {
  const AddChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();
    return SearchTemplate(
      title: "create_a_new_chat".tr,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: controller.contacts.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final UserModel contact = controller.contacts[index];
          return GestureDetector(
            onTap: () async {
              controller.selectedContactChat = contact;
              await controller.createChat();
              Get.toNamed(RouteName.chatRoom);
            },
            child: Container(
              color: Colors.white,
              width: Get.width,
              height: 58,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProfilePicture(
                                  size: 50, imageURL: contact.photoUrl),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      contact.username.replaceAll("@", ""),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppFont.text16.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: Text(
                                        contact.displayName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppFont.text12
                                            .copyWith(color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Line()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
