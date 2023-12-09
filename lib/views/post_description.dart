import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/post_controller.dart';
import '../widgets/global/line.dart';

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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
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
                                child: const Text(
                                  "Prev",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              const Text(
                                "Post",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        const Line()
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: TextField(
                      focusNode: controller.focusNode,
                      style: const TextStyle(fontSize: 16),
                      controller: controller.description,
                      maxLength: 1000,
                      maxLines: null,
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      onChanged: (text) {},
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "Apa yang ingin anda beritahukan?",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontFamily: "Nunito",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
