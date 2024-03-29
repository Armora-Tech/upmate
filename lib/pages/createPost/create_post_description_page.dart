import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/themes/app_font.dart';
import 'package:upmatev2/utils/input_validator.dart';
import '../../controllers/post_controller.dart';
import '../../routes/route_name.dart';
import '../../widgets/global/line.dart';

class PostDescriptionView extends StatelessWidget {
  const PostDescriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PostController>();
    return WillPopScope(
      onWillPop: () async {
        controller.description.clear();
        Get.back();
        return Future.value(false);
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 65, bottom: 10),
                height: Get.height,
                width: Get.width,
                child: SingleChildScrollView(
                  child: TextField(
                    focusNode: controller.focusNode,
                    style: AppFont.text16,
                    controller: controller.description,
                    maxLength: InputValidator.maxBioLength,
                    maxLines: null,
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    onChanged: (text) {},
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "what_do_you_want_to_share".tr,
                      hintStyle: AppFont.text14.copyWith(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: Container(
                  color: Colors.white,
                  width: Get.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.description.clear();
                                Get.back();
                              },
                              child: const Icon(Icons.arrow_back,
                                  size: 25, color: Colors.black),
                            ),
                            GestureDetector(
                              onTap: () => Get.toNamed(RouteName.postInterest),
                              child: Text(
                                "next".tr,
                                style: AppFont.text16.copyWith(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w600),
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
            ],
          ),
        ),
      ),
    );
  }
}
