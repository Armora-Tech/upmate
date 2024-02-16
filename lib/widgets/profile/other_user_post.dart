import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/profile_controller.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/widgets/global/skelton.dart';
import 'package:upmatev2/models/user_model.dart';

class OtherUserPost extends StatelessWidget {
  final UserModel user;
  const OtherUserPost({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return GetBuilder<ProfileController>(
      builder: (_) => !controller.isLoading.value && user.posts!.isEmpty
          ? Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text("no_posts".tr,
                    style: const TextStyle(color: Colors.grey)),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.only(top: 2),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.isLoading.value ? 6 : user.posts?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
              itemBuilder: (context, index) {
                return controller.isLoading.value
                    ? ShimmerSkelton(
                        height: Get.width / 3,
                        width: Get.width / 3,
                        borderRadius: 0)
                    : GestureDetector(
                        onTap: () => Get.toNamed(RouteName.postDetail,
                            arguments: user.posts![index]),
                        child: Container(
                          height: Get.width / 3,
                          width: Get.width / 3,
                          color: Colors.grey,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(user.posts![index].postPhoto![0],
                                  fit: BoxFit.cover),
                              user.posts![index].postPhoto!.length > 1
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
