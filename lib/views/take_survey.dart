import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/themes/app_color.dart';

class TakeSurveyView extends StatelessWidget {
  const TakeSurveyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Take Survey",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Dapatkan rekomendasi konten hasil personalisasi Anda.",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Apakah kamu suka logika matematika ?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: Get.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: AppColor.black)),
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: AppColor.lightGrey,
                          )),
                    ),
                    const Text(
                      "Ya",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                width: Get.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: AppColor.black)),
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Container(
                width: Get.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: AppColor.black)),
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: AppColor.lightGrey,
                          )),
                    ),
                    const Text(
                      "Tidak",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
