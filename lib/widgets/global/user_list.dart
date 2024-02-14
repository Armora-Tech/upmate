import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/user_model.dart';
import '../../routes/route_name.dart';
import '../../themes/app_font.dart';
import 'line.dart';
import 'profile_picture.dart';

enum SearchPage {
  createChatPage,
  searchChatPage,
  searchPage,
}

class UserList extends StatelessWidget {
  final SearchPage selectedPage;
  final dynamic controller;
  const UserList(
      {super.key, required this.selectedPage, required this.controller});

  @override
  Widget build(BuildContext context) {
    return controller.listSearchResult.isEmpty
        ? Container(
            margin: const EdgeInsets.only(top: 40),
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text("User not found",
                  style: AppFont.text12.copyWith(color: Colors.grey)),
            ),
          )
        : ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: controller.listSearchResult.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final UserModel contact = controller.listSearchResult[index];
              return GestureDetector(
                onTap: () async {
                  if (selectedPage == SearchPage.createChatPage) {
                    controller.selectedContact = contact;
                    await controller.createChat();
                  } else if (selectedPage == SearchPage.searchPage) {
                    Get.toNamed(RouteName.profile,
                        arguments: {"otherUser": contact});
                  } else {
                    controller.selectedContact = contact;
                    await controller.createChat();
                    Get.toNamed(RouteName.chatRoom);
                  }
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
          );
  }
}
