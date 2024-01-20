import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/widgets/global/line.dart';
import 'package:upmatev2/widgets/global/post_section.dart';
import 'package:upmatev2/widgets/global/skelton.dart';
import 'package:upmatev2/widgets/home/pop_up_delete_post.dart';
import 'package:upmatev2/widgets/home/popular.dart';
import '../../controllers/home_controller.dart';

class NewPost extends StatelessWidget {
  const NewPost({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final startController = Get.find<StartController>();
    return GetBuilder<HomeController>(builder: (_) {
      return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.isLoading.value ? 3 : controller.posts!.length,
          separatorBuilder: (context, index) {
            return !controller.isLoading.value &&
                    controller.posts!.length > 2 &&
                    index == 2
                ? const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Popular(),
                  )
                : const SizedBox(
                    height: 10,
                  );
          },
          itemBuilder: (context, index) {
            return Column(
              children: [
                GestureDetector(
                  onTap: controller.isLoading.value
                      ? () {}
                      : () {
                          controller.oldSelectedImage.value =
                              controller.posts![index].selectedDotsIndicator;
                          Get.toNamed(RouteName.postDetail,
                              arguments: controller.posts![index]);
                          controller.update();
                        },
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
                                      borderRadius: 0,
                                    )
                                  : Container(
                                      height: 35,
                                      width: 35,
                                      margin: const EdgeInsets.only(right: 10),
                                      clipBehavior: Clip.hardEdge,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColor.lightGrey),
                                      child: Image.network(
                                        controller.posts![index].userPhoto!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                              controller.isLoading.value
                                  ? const SizedBox(
                                      width: 10,
                                    )
                                  : const SizedBox(),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    controller.isLoading.value
                                        ? const ShimmerSkelton(
                                            height: 10, width: 120)
                                        : Text(
                                            controller.posts![index].user!
                                                .displayName,
                                            maxLines: 2,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                    controller.isLoading.value
                                        ? const SizedBox(
                                            height: 5,
                                          )
                                        : const SizedBox(),
                                    controller.isLoading.value
                                        ? const ShimmerSkelton(
                                            height: 10, width: 100)
                                        : Text(
                                            controller
                                                .posts![index].user!.username,
                                            maxLines: 2,
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        controller.isLoading.value
                            ? SvgPicture.asset(
                                "assets/svg/more_vert.svg",
                                height: 22,
                              )
                            : controller.posts![index].user!.uid ==
                                    startController.user!.uid
                                ? GestureDetector(
                                    onTap: () {
                                      PopUpDeletePost.showDialog(
                                          controller.posts![index], index);
                                    },
                                    child: SvgPicture.asset(
                                      "assets/svg/more_vert.svg",
                                      height: 22,
                                    ),
                                  )
                                : const SizedBox()
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                PostContent(
                    post: controller.isLoading.value
                        ? null
                        : controller.posts![index]),
                const SizedBox(
                  height: 10,
                ),
                const Line()
              ],
            );
          });
    });
  }
}
