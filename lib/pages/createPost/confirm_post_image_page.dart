import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/themes/app_font.dart';
import '../../controllers/camera_controller.dart';

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
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 15, 22, 25),
        body: SafeArea(
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: Get.width,
                  child: Image.file(controller.image!, fit: BoxFit.contain),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: IntrinsicWidth(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () => Get.toNamed(RouteName.postDescription),
                      child: Text(
                        "next".tr,
                        style:
                            AppFont.text14.copyWith(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    color: AppColor.primaryColor,
                    width: Get.width,
                    height: 65,
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () => Get.back(),
                                    child: const SizedBox(
                                      width: 28,
                                      child: Icon(Icons.arrow_back,
                                          size: 28, color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    "Confirm your image",
                                    style: AppFont.text20.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(width: 30)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
