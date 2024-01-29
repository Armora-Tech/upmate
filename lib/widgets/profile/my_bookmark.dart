import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upmatev2/widgets/global/skelton.dart';

import '../../controllers/start_controller.dart';
import '../../routes/route_name.dart';
import '../../themes/app_color.dart';

class MyBookmark extends StatelessWidget {
  const MyBookmark({super.key});

  @override
  Widget build(BuildContext context) {
    final startController = Get.find<StartController>();
    return GetBuilder<StartController>(
      builder: (_) => startController.myBookmarks!.isEmpty
          ? Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text("no_posts_saved".tr,
                    style: const TextStyle(color: Colors.grey)),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.only(top: 2),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: startController.isGettingMyPosts.value
                  ? 3
                  : startController.myBookmarks?.length,
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
                            arguments: startController.myBookmarks![index]),
                        child: Container(
                          height: Get.width / 3,
                          width: Get.width / 3,
                          color: AppColor.greyShimmer,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                  startController
                                      .myBookmarks![index].postPhoto![0],
                                  fit: BoxFit.cover),
                              startController.myBookmarks![index].postPhoto!
                                          .length >
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
