import 'package:flutter/material.dart';
import 'package:upmatev2/widgets/postSection/index.dart';
import '../widgets/home/app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 75),
              HomePostSection(),
              SizedBox(height: 60),
            ],
          ),
        ),
        HomeAppBar(),
      ],
    );
  }
}
