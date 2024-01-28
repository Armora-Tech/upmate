import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upmatev2/models/user_model.dart';

import '../../themes/app_color.dart';
import '../../themes/app_font.dart';
import 'line.dart';

class SearchTemplate extends StatelessWidget {
  final String title;
  final Widget child;
  final dynamic controller;
  const SearchTemplate(
      {super.key,
      required this.title,
      required this.child,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [const SizedBox(height: 128), child],
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                color: Colors.white,
                width: Get.width,
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.back();
                                    Get.back();
                                  },
                                  child: const Icon(Icons.arrow_back_rounded,
                                      size: 28, color: Colors.black),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  title,
                                  style: AppFont.text18
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              style: AppFont.text14,
                              controller: controller.searchText,
                              onChanged: controller.handleSearch,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColor.bgSearch,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(13),
                                  child: SvgPicture.asset(
                                    "assets/svg/search.svg",
                                    colorFilter: const ColorFilter.mode(
                                        AppColor.black, BlendMode.srcIn),
                                  ),
                                ),
                                suffixIcon: controller.isSearchTextEmpty.value
                                    ? const SizedBox()
                                    : GestureDetector(
                                        onTap: () {
                                          controller.isSearchTextEmpty.value =
                                              true;
                                          controller.searchText.clear();
                                          controller.listSearchResult =
                                              List<UserModel>.from(
                                                  controller.contacts);
                                          controller.update();
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Icon(Icons.close,
                                              color: AppColor.black, size: 20),
                                        ),
                                      ),
                                hintText: "search".tr,
                                hintStyle: AppFont.text14.copyWith(
                                  color: AppColor.black,
                                  fontFamily: "Nunito",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Line()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
