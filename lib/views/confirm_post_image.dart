import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/routes/route_name.dart';
import '../controllers/camera_controller.dart';

class ConfirmPostImageView extends StatelessWidget {
  const ConfirmPostImageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CameraViewController>();
    return WillPopScope(
        onWillPop: () async {
          controller.image!.deleteSync();
          Get.back();
          return Future.value(false);
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 15, 22, 25),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(children: [
                    Container(
                        width: Get.width,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.file(
                          controller.image!,
                          fit: BoxFit.contain,
                        )),
                    Positioned(
                      top: 0,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: GestureDetector(
                            onTap: () {
                              controller.image!.deleteSync();
                              Get.back();
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IntrinsicWidth(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onPressed: () => Get.toNamed(RouteName.postDescription),
                        child: const Text("Next",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.normal,
                                fontSize: 14)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
