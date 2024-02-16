import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:upmatev2/widgets/home/pop_up_delete_post.dart';

import '../../controllers/home_controller.dart';
import '../../controllers/start_controller.dart';
import '../../themes/app_color.dart';
import '../global/cached_network_image.dart';
import '../global/skelton.dart';

class PostHeader extends StatelessWidget {
  final int index;
  const PostHeader({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final startController = Get.find<StartController>();
    return GestureDetector(
      onTap: controller.isLoading.value
          ? () {}
          : () => controller.goToProfilePage(controller.posts![index].user!),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  controller.isLoading.value
                      ? const ShimmerSkelton(
                          height: 35,
                          width: 35,
                          isCircle: true,
                          borderRadius: 0)
                      : Container(
                          height: 35,
                          width: 35,
                          margin: const EdgeInsets.only(right: 10),
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.lightGrey),
                          child: CachedNetworkImageWidget(
                              imageUrl: controller.posts![index].userPhoto!,
                              circularProgressSize: 15,
                              heightPlaceHolder: 35,
                              widthPlaceHolder: 35,
                              radiusPlaceHolder: 35,
                              fit: BoxFit.cover),
                        ),
                  controller.isLoading.value
                      ? const SizedBox(width: 10)
                      : const SizedBox(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.isLoading.value
                            ? const ShimmerSkelton(height: 10, width: 120)
                            : Text(
                                controller.posts![index].user!.displayName,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                        controller.isLoading.value
                            ? const SizedBox(height: 5)
                            : const SizedBox(),
                        controller.isLoading.value
                            ? const ShimmerSkelton(height: 10, width: 100)
                            : Text(
                                controller.posts![index].user!.username,
                                maxLines: 2,
                                style: const TextStyle(color: Colors.grey),
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            controller.isLoading.value
                ? SvgPicture.asset("assets/svg/more_vert.svg", height: 22)
                : controller.posts![index].user!.uid ==
                        startController.user!.uid
                    ? GestureDetector(
                        onTap: () => PopUpDeletePost.showDialog(
                            controller.posts![index], index),
                        child: SvgPicture.asset("assets/svg/more_vert.svg",
                            height: 22),
                      )
                    : const SizedBox()
          ],
        ),
      ),
    );
  }
}
