import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/home_controller.dart';
import '../../themes/app_color.dart';
import 'detail_image.dart';

class PostImage extends StatelessWidget {
  final int index;
  const PostImage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Column(
      children: [
        Container(
          color: const Color.fromARGB(255, 18, 18, 18),
          width: Get.width,
          constraints: BoxConstraints(maxHeight: Get.width),
          child: CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1,
              aspectRatio: controller.posts![index].isCover ? 1 : 16 / 9,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                controller.selectedImage.value = index;
              },
            ),
            items: controller.posts![index].postPhoto!.map<Widget>((image) {
              return GestureDetector(
                onTap: () => Get.to(() => DetailImage(image: image),
                    opaque: false,
                    fullscreenDialog: true,
                    transition: Transition.noTransition),
                child: SizedBox(
                  width: Get.width,
                  child: Hero(
                      tag: image,
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                      )),
                ),
              );
            }).toList(),
          ),
        ),
        controller.posts![index].postPhoto!.length > 1
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    controller.posts![index].postPhoto!.length,
                    (index) => Obx(
                          () => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 3, vertical: 15),
                            child: Container(
                              height: 5,
                              width: 5,
                              decoration: BoxDecoration(
                                  color: controller.selectedImage.value == index
                                      ? Colors.grey
                                      : AppColor.lightGrey,
                                  shape: BoxShape.circle),
                            ),
                          ),
                        )),
              )
            : const SizedBox(
                height: 15,
              ),
      ],
    );
  }
}
