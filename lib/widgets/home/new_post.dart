import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/widgets/global/line.dart';
import 'package:upmatev2/widgets/global/post_image.dart';
import '../../controllers/home_controller.dart';

class NewPost extends StatelessWidget {
  const NewPost({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Column(
      children: [
        GestureDetector(
          onTap: () => Get.toNamed(RouteName.postDetail),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 35,
                  margin: const EdgeInsets.only(right: 10),
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Image.network(
                    "https://i.pinimg.com/736x/e5/93/09/e593098f04ed9c1f5fa05749ff0aff26.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Muhammad Rafli Silehu",
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "@raflisilehu | Mobile Developer at Google",
                        maxLines: 2,
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        PostImage(controller: controller),
        const SizedBox(
          height: 15,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(controller.action.length, (index) {
                    final item = controller.action;
                    return GestureDetector(
                      onTap: () => {},
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              item.values.elementAt(index),
                              size: 27,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              item.keys.elementAt(index),
                              style: const TextStyle(
                                fontSize: 9,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(() => RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                          children: [
                            TextSpan(
                              text: controller
                                  .handleText(controller.fullText.value),
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: GestureDetector(
                                onTap: () {
                                  controller.isFullText.value =
                                      !controller.isFullText.value;
                                },
                                child: Text(
                                  controller.isFullText.value
                                      ? " Sembunyikan"
                                      : "Selengkapnya",
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ),
                            ),
                          ]),
                    )),
                const SizedBox(
                  height: 5,
                ),
                const Text("Lihat semua 32 komentar",
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
                Row(
                  children: [
                    Container(
                      width: 25,
                      margin: const EdgeInsets.only(right: 10),
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.network(
                        "https://i.pinimg.com/736x/e5/93/09/e593098f04ed9c1f5fa05749ff0aff26.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontFamily: "Nunito"),
                                children: [
                                  TextSpan(
                                    text: "Flora Shafiqa ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: "Keren banget kak (emot api)",
                                  ),
                                ]),
                          ),
                          const Text(
                            "2 jam",
                            maxLines: 2,
                            style: TextStyle(color: Colors.grey, fontSize: 9),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 25,
                      margin: const EdgeInsets.only(right: 10),
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.network(
                        "https://i.pinimg.com/736x/e5/93/09/e593098f04ed9c1f5fa05749ff0aff26.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Flora Shafiqa",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Expanded(
                                child: Text(
                                  "not bad...(emot keren)",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text(
                            "2 jam",
                            maxLines: 2,
                            style: TextStyle(color: Colors.grey, fontSize: 9),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
        const SizedBox(
          height: 5,
        ),
        const Line()
      ],
    );
  }
}
