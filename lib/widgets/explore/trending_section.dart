import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/home_controller.dart';
import 'package:upmatev2/widgets/global/skelton.dart';

import '../../routes/route_name.dart';
import '../../themes/app_font.dart';
import '../global/profile_picture.dart';

class TrendingSection extends StatelessWidget {
  const TrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return !homeController.isLoading.value &&
            homeController.trendingPost!.isEmpty
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Row(
                  children: [
                    Text("Trending",
                        style: AppFont.text16
                            .copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 5),
                    const Icon(Icons.local_fire_department_outlined, size: 20)
                  ],
                ),
              ),
              GetBuilder<HomeController>(
                builder: (_) => SizedBox(
                  height: 250,
                  width: Get.width,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    itemCount: homeController.isLoading.value
                        ? 4
                        : homeController.trendingPost!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return homeController.isLoading.value
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: index == 0 ? 20 : 0,
                                  right: index == 3 ? 20 : 0),
                              child: ShimmerSkelton(
                                  height: 180, width: Get.width / 2 - 25),
                            )
                          : Container(
                              margin: EdgeInsets.only(
                                  left: index == 0 ? 20 : 0,
                                  right: index ==
                                          homeController.trendingPost!.length -
                                              1
                                      ? 20
                                      : 0),
                              height: 180,
                              width: Get.width / 2 - 25,
                              child: Material(
                                clipBehavior: Clip.hardEdge,
                                borderRadius: BorderRadius.circular(20),
                                child: InkWell(
                                  onTap: () => Get.toNamed(RouteName.postDetail,
                                      arguments:
                                          homeController.trendingPost![index]),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Ink.image(
                                          image: CachedNetworkImageProvider(
                                              homeController
                                                  .trendingPost![index]
                                                  .postPhoto![0]),
                                          fit: BoxFit.cover),
                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: const LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.transparent,
                                                Colors.transparent,
                                                Color.fromARGB(127, 0, 0, 0),
                                                Color.fromARGB(230, 0, 0, 0)
                                              ]),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                homeController
                                                    .trendingPost![index]
                                                    .user!
                                                    .displayName,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Text(
                                              homeController
                                                  .trendingPost![index]
                                                  .postDescription,
                                              maxLines: 2,
                                              style: AppFont.text12.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 10,
                                        left: 10,
                                        child: GestureDetector(
                                          onTap: () => Get.toNamed(
                                              RouteName.profile,
                                              arguments: {
                                                "otherUser": homeController
                                                    .trendingPost![index].user
                                              }),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.white),
                                            ),
                                            child: ProfilePicture(
                                                size: 40,
                                                imageURL: homeController
                                                    .trendingPost![index]
                                                    .userPhoto),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
  }
}
