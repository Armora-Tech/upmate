import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/themes/app_color.dart';

import '../routes/route_name.dart';
import '../themes/app_font.dart';

class TagInterestView extends StatelessWidget {
  const TagInterestView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> tags = [
      "Data Science",
      "Statistika",
      "Machine Learning",
      " Programming",
      "Kalkulus",
      "Aljabar Linier",
      "Sistem digital",
      "Matematika",
      "Akuntan",
      "Fisika",
      "Robotik"
    ];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SizedBox(
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Tag Interest",
                        style: AppFont.doubleExtraLargeText
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Dapatkan rekomendasi konten hasil personalisasi Anda. Anda dapat memilih hingga 4 opsi",
                        style:
                            AppFont.semiMediumText.copyWith(color: Colors.grey),
                        overflow: TextOverflow.clip,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("Apakah kamu suka logika matematika ?",
                          style: AppFont.semiLargeText
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 30,
                      ),
                      Wrap(
                        runSpacing: 20,
                        spacing: 20,
                        runAlignment: WrapAlignment.center,
                        direction: Axis.horizontal,
                        children: List.generate(
                          tags.length,
                          (index) => Container(
                            width: Get.width / 2 - 45,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1, color: AppColor.lightGrey)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "# ${tags[index]}",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: ElevatedButton(
                        onPressed: () => Get.toNamed(RouteName.start),
                        child: const Center(
                            child: Text(
                          "Next",
                          style: TextStyle(color: Colors.white),
                        ))))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
