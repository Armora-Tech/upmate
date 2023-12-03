import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  const Comment({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Row(
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
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: "Keren banget kak (emot api)",
                        ),
                      ]),
                ),
                const Row(
                  children: [
                    Text(
                      "2 jam",
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "2 suka",
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Balas",
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Kirim",
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
