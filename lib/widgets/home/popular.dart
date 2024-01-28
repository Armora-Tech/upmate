import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/widgets/global/line.dart';

import '../global/title_section.dart';
import 'list_view_popular.dart';

class Popular extends StatelessWidget {
  const Popular({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        TitleSection(title: "popular".tr),
        const SizedBox(height: 20),
        const ListViewPopular(),
        const SizedBox(height: 20),
        // TitleSection(title: "people_with_similar_interests".tr),
        // const SizedBox(height: 20),
        // const ListViewPopular(),
        const SizedBox(height: 10),
        const Line(),
      ],
    );
  }
}
