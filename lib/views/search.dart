import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/themes/app_color.dart';

import '../widgets/global/line.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(children: [
          const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              color: Colors.white,
              width: Get.width,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.arrow_back_rounded,
                                size: 28,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Search",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColor.bgSearch,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "Search",
                              hintStyle: const TextStyle(
                                color: AppColor.black,
                                fontSize: 14,
                                fontFamily: "Nunito",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Line()
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}