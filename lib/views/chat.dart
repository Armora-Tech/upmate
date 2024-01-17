import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/widgets/chat/chat_list.dart';
import 'package:upmatev2/widgets/chat/shimmer.dart';
import 'package:upmatev2/widgets/global/line.dart';

import '../controllers/chat_controller.dart';
import '../themes/app_color.dart';
import '../themes/app_font.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());
    controller.loading();
    return Obx(() => controller.isLoading.value
        ? const ChatShimmer()
        : Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: controller.isShowSearch.value ? 140 : 80,
                ),
                Expanded(child: ChatList())
              ],
            ),
            Positioned(
                bottom: 80,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () => Get.toNamed(RouteName.addChat),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                )),
            Positioned(
              top: 0,
              child: SafeArea(
                child: AnimatedContainer(
                  duration: Duration(
                      milliseconds: controller.isShowSearch.value ? 300 : 0),
                  height: controller.isShowSearch.value ? 120 : 60,
                  curve: Curves.easeInOut,
                  color: Colors.white,
                  width: Get.width,
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 13),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "chat".tr,
                                  style: AppFont.text23.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(children: [
                                  GestureDetector(
                                    onTap: () =>
                                        controller.isShowSearch.toggle(),
                                    child: SvgPicture.asset(
                                      "assets/svg/search.svg",
                                      colorFilter: const ColorFilter.mode(
                                          AppColor.black, BlendMode.srcIn),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SvgPicture.asset(
                                    "assets/svg/more_vert.svg",
                                    height: 22,
                                  ),
                                ])
                              ],
                            ),
                            controller.isShowSearch.value
                                ? Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: TextField(
                                      style: AppFont.text14,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColor.bgSearch,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide.none),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0, right: 10),
                                          child: SvgPicture.asset(
                                              "assets/svg/search.svg",
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                      Colors.grey,
                                                      BlendMode.srcIn),
                                              semanticsLabel: 'Search'),
                                        ),
                                        hintText: "search".tr,
                                        hintStyle: AppFont.text14.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox()
                          ]),
                        ),
                        const Align(
                            alignment: Alignment.bottomCenter, child: Line())
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]));
  }
}
