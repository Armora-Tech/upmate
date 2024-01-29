import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:upmatev2/widgets/home/popular.dart';
import 'package:upmatev2/widgets/postSection/shimmer_post_section.dart';
import '../../controllers/home_controller.dart';
import 'post_section.dart';

class HomePostSection extends StatelessWidget {
  const HomePostSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return GetBuilder<HomeController>(
      builder: (_) {
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.isLoading.value ? 3 : controller.posts!.length,
          separatorBuilder: (context, index) {
            return !controller.isLoading.value &&
                    controller.posts!.length > 2 &&
                    index == 2
                ? const Padding(
                    padding: EdgeInsets.only(bottom: 10.0), child: Popular())
                : const SizedBox(height: 10);
          },
          itemBuilder: (context, index) {
            return controller.isLoading.value
                ? const ShimmerPostSection()
                : Column(
                    children: [
                      PostSection(index: index),
                      Obx(() => controller.isLoadMore.value &&
                              index == controller.posts!.length - 1
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 40, top: 20),
                              child: LoadingAnimationWidget.stretchedDots(
                                  size: 30, color: Colors.black),
                            )
                          : const SizedBox()),
                    ],
                  );
          },
        );
      },
    );
  }
}
