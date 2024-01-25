import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_font.dart';
import '../global/line.dart';

class PostDetailAppBar extends StatelessWidget {
  const PostDetailAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: Container(
        color: Colors.white,
        width: Get.width,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const SizedBox(
                        width: 30,
                        child: Icon(Icons.arrow_back, color: Colors.black),
                      ),
                    ),
                    Text(
                      "Post",
                      style:
                          AppFont.text20.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 30)
                  ],
                ),
              ),
              const Line(),
            ],
          ),
        ),
      ),
    );
  }
}
