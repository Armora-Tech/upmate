import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/models/post_model.dart';

import '../../controllers/home_controller.dart';
import '../../themes/app_font.dart';
import '../global/skelton.dart';

class PostDescription extends StatelessWidget {
  final PostModel post;
  const PostDescription({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return controller.isLoading.value
        ? const ShimmerSkelton(height: 10, width: 80)
        : post.postDescription.isEmpty
            ? const SizedBox()
            : GetBuilder<HomeController>(
                builder: (_) => RichText(
                  text: TextSpan(
                    style: AppFont.text14,
                    children: [
                      TextSpan(
                        text:
                            "${post.user!.displayName.replaceAll(" ", "").toLowerCase()}  ",
                        style: AppFont.text14
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: controller.handleText(post)),
                      post.postDescription.length > 80
                          ? WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: GestureDetector(
                                onTap: () {
                                  post.isFullDesc = !post.isFullDesc;
                                  controller.update();
                                },
                                child: Text(
                                  post.isFullDesc ? "less".tr : "more".tr,
                                  style: AppFont.text12
                                      .copyWith(color: Colors.grey),
                                ),
                              ),
                            )
                          : const WidgetSpan(child: SizedBox()),
                    ],
                  ),
                ),
              );
  }
}
