import 'package:flutter/material.dart';
import 'package:upmatev2/controllers/gallery_controller.dart';

class ScrollUp extends StatelessWidget {
  final GalleryController controller;
  const ScrollUp({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        duration: const Duration(milliseconds: 300),
        bottom: controller.isBtnShown.value ? 15 : -50,
        child: GestureDetector(
          onTap: () => controller.scrollController.animateTo(0,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOut),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: const Row(children: [
              Text(
                "Gulir ke atas",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_upward_rounded,
                size: 20,
                color: Colors.black,
              ),
            ]),
          ),
        ));
  }
}
