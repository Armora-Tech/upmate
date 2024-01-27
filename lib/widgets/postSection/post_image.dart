import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/observer/dots_indicator_controller.dart';
import 'package:upmatev2/models/post_model.dart';
import '../../themes/app_color.dart';
import '../global/cached_network_image.dart';
import '../global/detail_image.dart';

class PostImage extends StatelessWidget {
  final PostModel post;
  const PostImage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final dotsController = Get.find<DostIndicatorController>();
    return Column(
      children: [
        Container(
          width: Get.width,
          constraints: BoxConstraints(maxHeight: Get.width),
          child: CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1,
              aspectRatio: post.isCover ? 1 : 16 / 9,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                post.selectedDotsIndicator = index;
                dotsController.update();
              },
            ),
            items: post.postPhoto!.map<Widget>(
              (image) {
                return GestureDetector(
                  onTap: () => Get.to(() => DetailImage(image: image),
                      opaque: false,
                      fullscreenDialog: true,
                      transition: Transition.noTransition),
                  child: SizedBox(
                    width: Get.width,
                    child: Hero(
                      tag: image,
                      child: CachedNetworkImageWidget(
                          imageUrl: image,
                          circularProgressSize: 30,
                          heightPlaceHolder: Get.width,
                          widthPlaceHolder: Get.width,
                          radiusPlaceHolder: 0,
                          fit: BoxFit.cover),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
        post.postPhoto!.length > 1
            ? GetBuilder<DostIndicatorController>(
                builder: (_) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    post.postPhoto!.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 15),
                      child: Container(
                        height: 5,
                        width: 5,
                        decoration: BoxDecoration(
                            color: post.selectedDotsIndicator ==
                                    post.postPhoto!
                                        .indexOf(post.postPhoto![index])
                                ? Colors.grey
                                : AppColor.lightGrey,
                            shape: BoxShape.circle),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(height: 15),
      ],
    );
  }
}
