import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/edit_profile_controller.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/themes/app_font.dart';
import 'package:upmatev2/widgets/global/bottom_sheet.dart';
import 'package:upmatev2/widgets/editProfile/edit_page.dart';
import 'package:upmatev2/widgets/global/line.dart';
import 'package:upmatev2/widgets/global/profile_picture.dart';

import '../widgets/global/detail_profile_picture.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditProfileController>();
    final startController = Get.find<StartController>();
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            GetBuilder<EditProfileController>(
                builder: (_) => Padding(
                      padding:
                          const EdgeInsets.only(right: 20, left: 20, top: 120),
                      child: Column(
                        children: [
                          GestureDetector(
                              onTap: () => Get.to(
                                  () => const DetailProfilePicture(),
                                  opaque: false,
                                  fullscreenDialog: true,
                                  transition: Transition.circularReveal),
                              child: Hero(
                                  tag: "pp_edit_profile",
                                  child: controller.image != null
                                      ? Container(
                                          width: 120,
                                          height: 120,
                                          clipBehavior: Clip.hardEdge,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle),
                                          child: Image.file(
                                            controller.image!,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      :  ProfilePicture(
                                        imageURL: startController.photoURL,
                                          size: 120,
                                        ))),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () =>
                                BottomSheetWidget.showChooseImage(controller),
                            child: const Text(
                              "Ubah Gambar",
                              style: TextStyle(
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Column(
                            children:
                                List.generate(controller.data!.length, (index) {
                              final Map<String, dynamic> data = controller.data!;
                              return GestureDetector(
                                onTap: () {
                                  controller.chooseInput(
                                      controller.data!.keys.elementAt(index));
                                  Get.to(() => EditPage(index: index),
                                      transition: Transition.rightToLeft);
                                },
                                child: Container(
                                  color: Colors.white,
                                  height: 50,
                                  width: Get.width,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15.0),
                                              child: Text(
                                                data.keys.elementAt(index),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                          Expanded(
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(data.values
                                                      .elementAt(index)))),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15.0),
                                              child: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: Colors.black,
                                                size: 20,
                                              ))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: Get.width,
                                        height: 0.5,
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                    )),
            Positioned(
              top: 0,
              child: Container(
                color: Colors.white,
                width: Get.width,
                child: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => Get.back(),
                                child: const SizedBox(
                                    width: 28,
                                    child: Icon(
                                      Icons.arrow_back,
                                      size: 28,
                                    )),
                              ),
                              Text(
                                "Edit Profile",
                                style: AppFont.text20
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 30,
                              )
                            ],
                          ),
                        ),
                      ),
                      const Line(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
