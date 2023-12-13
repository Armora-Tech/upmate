import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/themes/app_font.dart';
import 'package:upmatev2/widgets/explore/interest_box.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> tags = ["Machine Learning", "Kalkulus", "Aljabar", "Ekonomi"];
    return Stack(children: [
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Tag interest mu",
                  style: AppFont.semiLargeText
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const InterestBox(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Tag interest lainnya",
                  style: AppFont.semiLargeText
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                    tags.length,
                    (index) => Column(
                          children: [
                            Text(
                              "#${tags[index]}",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        )),
              ),
              const SizedBox(
                height: 90,
              )
            ],
          ),
        ),
      ),
      Positioned(
        top: 0,
        child: Container(
          color: Colors.white,
          width: Get.width,
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 13),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            backgroundColor: AppColor.bgSearch),
                        onPressed: () => Get.toNamed(RouteName.search),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13.0, vertical: 3),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.search,
                                      color: Colors.black,
                                      size: 23,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text("Search", style: AppFont.defaultText)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ))),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
