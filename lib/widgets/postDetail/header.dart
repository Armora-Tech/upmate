import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/start_controller.dart';
import '../../models/post_model.dart';
import '../global/cached_network_image.dart';
import '../home/pop_up_delete_post.dart';

class PostDetailHeader extends StatelessWidget {
  final PostModel post;
  const PostDetailHeader({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final startController = Get.find<StartController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  height: 35,
                  width: 35,
                  margin: const EdgeInsets.only(right: 10),
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: CachedNetworkImageWidget(
                      imageUrl: post.userPhoto!,
                      circularProgressSize: 20,
                      heightPlaceHolder: 35,
                      widthPlaceHolder: 35,
                      radiusPlaceHolder: 35,
                      fit: BoxFit.cover),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.user!.displayName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        post.user!.username,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          post.user!.uid == startController.user!.uid
              ? GestureDetector(
                  onTap: () {
                    PopUpDeletePost.showDialogFromPostDetail(post);
                  },
                  child:
                      SvgPicture.asset("assets/svg/more_vert.svg", height: 22),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
