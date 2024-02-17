import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/edit_profile_controller.dart';

import 'edit_page.dart';

class UserDataEditProfile extends StatelessWidget {
  const UserDataEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditProfileController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: List.generate(
          controller.data!.length,
          (index) {
            final Map<String, dynamic> data = controller.data!;
            return GestureDetector(
              onTap: () {
                controller.chooseInput(controller.data!.keys.elementAt(index));
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Text(
                            data.keys.elementAt(index),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(data.values.elementAt(index)),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Icon(Icons.arrow_forward_ios_rounded,
                              color: Colors.black, size: 20),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    Container(
                        width: Get.width, height: 0.5, color: Colors.black)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
