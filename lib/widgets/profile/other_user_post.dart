import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/profile_controller.dart';
import 'package:upmatev2/routes/route_name.dart';

class OtherUserPost extends StatelessWidget {
  const OtherUserPost({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return !controller.isLoading.value && controller.otherUser.posts!.isEmpty
        ? Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text("no_posts".tr,
                  style: const TextStyle(color: Colors.grey)),
            ),
          )
        : GetBuilder<ProfileController>(
            builder: (_) {
              return controller.isLoading.value
                  ? const Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: CircularProgressIndicator(
                            color: Colors.grey, strokeWidth: 2),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.only(top: 2),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.otherUser.posts?.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteName.postDetail,
                                arguments: controller.otherUser.posts![index]);
                          },
                          child: Container(
                            height: Get.width / 3,
                            width: Get.width / 3,
                            color: Colors.grey,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                    controller
                                        .otherUser.posts![index].postPhoto![0],
                                    fit: BoxFit.cover),
                                controller.otherUser.posts![index].postPhoto!
                                            .length >
                                        1
                                    ? Positioned(
                                        top: 5,
                                        right: 5,
                                        child: SvgPicture.asset(
                                          "assets/svg/multiple_post.svg",
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        );
                      },
                    );
            },
          );
  }
}
