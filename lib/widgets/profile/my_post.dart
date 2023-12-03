import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/routes/route_name.dart';

class MyPost extends StatelessWidget {
  const MyPost({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      "assets/images/naruto.jpg",
      "assets/images/quran.png",
      "assets/images/gojek.png",
      "assets/images/movie-app.png",
      "assets/images/jkt-app.png",
    ];
    return GridView.builder(
      padding: const EdgeInsets.only(top: 2),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: images.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: ()=> Get.toNamed(RouteName.postDetail),
          child: Container(
            height: Get.width / 3,
            width: Get.width / 3,
            color: Colors.grey,
            child: Image.asset(
              images[index],
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
