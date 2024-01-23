import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_color.dart';
import '../../themes/app_font.dart';
import '../global/line.dart';
import '../global/profile_picture.dart';

class AppBarChatRoom extends StatelessWidget {
  const AppBarChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
                        top: 0,
                        child: Container(
                          color: AppColor.primaryColor,
                          width: Get.width,
                          child: SafeArea(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 13, vertical: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () => Get.back(),
                                              child: const Icon(
                                                Icons.arrow_back,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            const ProfilePicture(size: 40),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Muhammad Rafli Silehu",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "online".tr,
                                                    style:
                                                        AppFont.text12.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Icon(
                                          Icons.more_vert_rounded,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Line()
                              ],
                            ),
                          ),
                        ),
                      );
  }
}