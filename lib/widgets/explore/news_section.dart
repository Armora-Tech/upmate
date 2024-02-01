import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_font.dart';

class NewsSection extends StatelessWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> news = [
      {
        "thumbnail": "assets/images/news_1.webp",
        "headlineText":
            "Rising Concerns Over AI Hallucinations and Bias: Aporia’s 2024 Report Highlights Urgent Need for Industry Standards"
      },
      {
        "thumbnail": "assets/images/news_2.webp",
        "headlineText":
            "Meta Stock Rising as Facebook Parent Spends Big on AI—Key Technical Levels to Monitor"
      },
      {
        "thumbnail": "assets/images/news_3.webp",
        "headlineText":
            "AI Rising: 7 Technology Leaders Provide A View From Davos"
      },
      {
        "thumbnail": "assets/images/news_4.webp",
        "headlineText":
            "The Rising Energy Demand of AI and Clouds: Unraveling the Environmental Conundrum"
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Row(
            children: [
              Text("News",
                  style: AppFont.text16.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(width: 5),
              const Icon(Icons.feed_outlined, size: 15)
            ],
          ),
        ),
        SizedBox(
          height: 150,
          width: Get.width,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: news.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final String thumbnail = news[index]["thumbnail"]!;
              final String headlineText = news[index]["headlineText"]!;
              return Container(
                clipBehavior: Clip.hardEdge,
                width: 300,
                height: 100,
                margin: EdgeInsets.only(
                    left: index == 0 ? 20 : 0,
                    right: index == news.length -1
                        ? 20
                        : 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 0.5, color: Colors.grey),
                ),
                child: Material(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(headlineText,
                                style: AppFont.text14
                                    .copyWith(fontWeight: FontWeight.bold),
                                maxLines: 5),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            child: Ink.image(
                                alignment: Alignment.center,
                                image: AssetImage(thumbnail),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
