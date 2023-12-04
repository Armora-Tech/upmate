import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/chat_room_controller.dart';

class BottomSheetUtil {
  static void showBottomDialog(ChatRoomController controller) {
    Get.bottomSheet(
      Container(
          height: 200,
          width: Get.width,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Pilih Gambar",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.isGallery.value = false;
                    controller.selectImage(controller.isGallery.value);
                  },
                  child: const IntrinsicWidth(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                            size: 26,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Ambil Foto",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.isGallery.value = true;
                    controller.selectImage(controller.isGallery.value);
                  },
                  child: const IntrinsicWidth(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(children: [
                          Icon(
                            Icons.image_rounded,
                            color: Colors.white,
                            size: 26,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Pilih dari gallery anda",
                            style: TextStyle(color: Colors.white),
                          ),
                        ])),
                  )),
            ],
          )),
    );
  }
}
