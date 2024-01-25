import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/themes/app_font.dart';

import '../routes/route_name.dart';

class TakeSurveyView extends StatelessWidget {
  const TakeSurveyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SizedBox(
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text("Take Survey",
                        style: AppFont.text28
                            .copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(
                        "Dapatkan rekomendasi konten hasil personalisasi Anda.",
                        overflow: TextOverflow.clip,
                        style: AppFont.text12.copyWith(color: Colors.grey)),
                    const SizedBox(height: 20),
                    Text("Apakah kamu suka logika matematika ?",
                        style: AppFont.text16
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 30),
                    Container(
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: Row(
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: AppColor.lightGrey,
                              ),
                            ),
                          ),
                          const Text("Ya",
                              style: TextStyle(fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: Row(
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: AppColor.lightGrey,
                                )),
                          ),
                          const Text(
                            "Kurang suka",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: Row(
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: AppColor.lightGrey,
                              ),
                            ),
                          ),
                          const Text(
                            "Tidak",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: ElevatedButton(
                    onPressed: () => Get.toNamed(RouteName.tagInterest),
                    child: const Center(
                      child:
                          Text("Next", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
