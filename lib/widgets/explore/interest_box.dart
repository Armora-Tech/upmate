import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InterestBox extends StatelessWidget {
  const InterestBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
        runSpacing: 10,
        spacing: 10,
        direction: Axis.horizontal,
        children: List.generate(
          4,
          (index) => Container(
            height: 180,
            width: Get.width / 2 - 25,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.grey),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  "assets/images/interest.jpg",
                  fit: BoxFit.cover,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Color.fromARGB(127, 0, 0, 0),
                            Color.fromARGB(230, 0, 0, 0)
                          ])),
                  child: const Text(
                    "#Matematika",
                    maxLines: 3,
                    style: TextStyle(
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
