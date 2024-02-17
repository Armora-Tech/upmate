import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/models/user_model.dart';
import 'package:upmatev2/repositories/user_repository.dart';
import 'package:upmatev2/widgets/profile/description.dart';
import 'package:upmatev2/widgets/profile/header.dart';
import 'package:upmatev2/widgets/profile/other_user_post.dart';

import '../controllers/profile_controller.dart';
import '../widgets/global/line.dart';

class OtherUserProfileView extends StatefulWidget {
  final UserModel otherUser;
  const OtherUserProfileView({super.key, required this.otherUser});

  @override
  State<OtherUserProfileView> createState() => _OtherUserProfileViewState();
}

class _OtherUserProfileViewState extends State<OtherUserProfileView> {
  final controller = Get.put(ProfileController());
  @override
  void initState() {
    super.initState();
    _getOtherUserPosts();
  }

  Future<void> _getOtherUserPosts() async {
    controller.isLoading.value = true;
    controller.isFullText.value = false;
    widget.otherUser.posts =
        await UserRepository().getUserPosts(userRef: widget.otherUser.ref);
    controller.isLoading.value = false;
    controller.update();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.isFullText.value = false;
        controller.update();
        Get.back();
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          body: GetBuilder<ProfileController>(
            builder: (_) => NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    expandedHeight: controller.isFullText.value
                        ? Get.width * 9 / 16 + 305
                        : (widget.otherUser.bio == null ||
                                widget.otherUser.bio == "")
                            ? Get.width * 9 / 16 + 195
                            : Get.width * 9 / 16 + 245,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeaderProfile(user: widget.otherUser),
                          const SizedBox(height: 5),
                          DescriptionProfile(user: widget.otherUser)
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: Column(
                children: [
                  const SizedBox(height: 20),
                  const Line(),
                  Expanded(child: OtherUserPost(user: widget.otherUser))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
