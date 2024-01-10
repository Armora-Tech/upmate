import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/widgets/global/line.dart';
import 'package:upmatev2/widgets/global/post_section.dart';
import 'package:upmatev2/widgets/global/skelton.dart';
import '../../controllers/home_controller.dart';

class NewPost extends StatelessWidget {
  const NewPost({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return GetBuilder<HomeController>(
        builder: (_) => ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.posts?.length ?? 3,
            separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: controller.isLoading.value
                        ? () {}
                        : () {
                            controller.selectedIndex.value = index;
                            Get.toNamed(
                              RouteName.postDetail,
                            );
                          },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                      shape: BoxShape.circle),
                                  child: Image.network(
                                    controller.posts![index].userPhoto == ""
                                        ? "https://www.mmm.ucar.edu/sites/default/files/img/default-avatar.jpg"
                                        : controller.posts![index].userPhoto!,
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
                                        controller
                                            .posts![index].user!.displayName,
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
                                        controller.posts![index].user!.username,
                                        maxLines: 2,
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PostContent(index: index),
                  const SizedBox(
                    height: 10,
                  ),
                  const Line()
                ],
              );
            }));
  }
}
