import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_font.dart';

class OtherTagInterestSection extends StatelessWidget {
  const OtherTagInterestSection({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> tags = [
      "Machine Learning",
      "physics".tr,
      "robotic".tr,
      "statistics".tr
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text("${"other_interest_tags".tr} #",
              style: AppFont.text16.copyWith(fontWeight: FontWeight.bold)),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            tags.length,
            (index) => Column(
              children: [
                Text("#${tags[index]}",
                    style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 5)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
