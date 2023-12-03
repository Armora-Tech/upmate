import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../themes/app_color.dart';
import 'zoom_post_image.dart';

class PostImage extends StatelessWidget {
  final dynamic controller;
  const PostImage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color.fromARGB(255, 18, 18, 18),
          height: 225,
          clipBehavior: Clip.none,
          child: AspectRatio(
              aspectRatio: 16.0 / 9,
              child: CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1,
                  aspectRatio: 3 / 4,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    controller.selectedIndex.value = index;
                  },
                ),
                items: controller.images.map<Widget>((image) {
                  return GestureDetector(
                    onTap: () => Get.to(() => ZoomPostImage(image: image),
                        opaque: false,
                        fullscreenDialog: true,
                        transition: Transition.noTransition),
                    child: Hero(
                        tag: image,
                        child: Image.asset(image, fit: BoxFit.cover)),
                  );
                }).toList(),
              )),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              controller.images.length,
              (index) => Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Container(
                        height: 5,
                        width: 5,
                        decoration: BoxDecoration(
                            color: controller.selectedIndex.value == index
                                ? Colors.grey
                                : AppColor.lightGrey,
                            shape: BoxShape.circle),
                      ),
                    ),
                  )),
        ),
      ],
    );
  }
}
