import 'package:flutter/material.dart';
import 'package:upmatev2/widgets/explore/app_bar.dart';
import 'package:upmatev2/widgets/explore/tag_interest_section.dart';
import 'package:upmatev2/widgets/explore/news_section.dart';

import '../widgets/explore/other_tag_interest_section.dart';
import '../widgets/explore/trending_section.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              TrendingSection(),
              NewsSection(),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [TagInterestSection(), OtherTagInterestSection()],
                ),
              ),
              SizedBox(height: 90)
            ],
          ),
        ),
        ExploreAppBar()
      ],
    );
  }
}
