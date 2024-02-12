import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/home_controller.dart';
import 'package:upmatev2/widgets/postSection/index.dart';
import '../widgets/home/app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Stack(
      children: [
        SingleChildScrollView(
          controller: controller.scrollController,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 75),
              HomePostSection(),
              SizedBox(height: 60)
            ],
          ),
        ),
        const HomeAppBar(),
      ],
    );
  }
}
