import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:upmatev2/widgets/global/profile_picture.dart';

class Follow extends StatelessWidget {
  const Follow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: Get.width,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ProfilePicture(size: 40),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Muhammad Rafli Silehu",
                        maxLines: 2,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Telah mengikuti anda.",
                              maxLines: 1,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Text(
                            "1 menit",
                            maxLines: 1,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            height: 30,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    )),
                child: const Center(
                  child: Text(
                    "Ikuti balik",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
