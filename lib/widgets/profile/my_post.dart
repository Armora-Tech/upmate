import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_color.dart';

import '../global/skelton.dart';

class MyPost extends StatelessWidget {
  const MyPost({super.key});

  @override
  Widget build(BuildContext context) {
    final startController = Get.find<StartController>();
    return startController.myPosts!.isEmpty
        ? Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text("no_posts".tr,
                  style: const TextStyle(color: Colors.grey)),
            ),
          )
        : GetBuilder<StartController>(
            builder: (_) => GridView.builder(
              padding: const EdgeInsets.only(top: 2),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: startController.isGettingMyPosts.value
                  ? 6
                  : startController.myPosts?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
              itemBuilder: (context, index) {
                return startController.isGettingMyPosts.value
                    ? ShimmerSkelton(
                        height: Get.width / 3,
                        width: Get.width / 3,
                        borderRadius: 0)
                    : GestureDetector(
                        onTap: () => Get.toNamed(RouteName.postDetail,
                            arguments: startController.myPosts![index]),
                        child: Container(
                          height: Get.width / 3,
                          width: Get.width / 3,
                          color: AppColor.greyShimmer,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                  startController.myPosts![index].postPhoto![0],
                                  fit: BoxFit.cover),
                              startController
                                          .myPosts![index].postPhoto!.length >
                                      1
                                  ? Positioned(
                                      top: 5,
                                      right: 5,
                                      child: SvgPicture.asset(
                                          "assets/svg/multiple_post.svg"),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      );
              },
            ),
          );
  }
}
