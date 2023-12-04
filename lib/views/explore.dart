import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/themes/app_color.dart';
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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Tag interest mu",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const InterestBox(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Tag interest lainnya",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  child: TextField(
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColor.lightGrey,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      hintText: "Search",
                      hintStyle: const TextStyle(
                        color: AppColor.black,
                        fontSize: 14,
                        fontFamily: "Nunito",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
