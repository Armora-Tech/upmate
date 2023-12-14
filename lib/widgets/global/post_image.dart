import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../themes/app_color.dart';
import 'detail_image.dart';

class PostImage extends StatelessWidget {
  final dynamic controller;
  const PostImage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color.fromARGB(255, 18, 18, 18),
          clipBehavior: Clip.none,
          width: Get.width,
          height: Get.width,
          child: CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1,
              aspectRatio: 1,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                controller.selectedIndex.value = index;
              },
            ),
            items: controller.images.map<Widget>((image) {
              return GestureDetector(
                onTap: () => Get.to(() => DetailImage(image: image),
                    opaque: false,
                    fullscreenDialog: true,
                    transition: Transition.noTransition),
                child: SizedBox(
                  width: Get.width,
                  child: Hero(
                      tag: image,
                      child: Image.asset(image, fit: BoxFit.contain)),
                ),
              );
            }).toList(),
          ),
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
