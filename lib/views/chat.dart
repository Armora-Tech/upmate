import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/widgets/chat/chat_list.dart';
import 'package:upmatev2/widgets/global/line.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 80,
          ),
          Expanded(child: ChatList())
        ],
      ),
      Positioned(
          bottom: 80,
          right: 20,
          child: FloatingActionButton(
            onPressed: () {},
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )),
      Positioned(
        top: 0,
        child: Container(
          color: Colors.white,
          width: Get.width,
          child: const SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Chats",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(children: [
                        Icon(
                          Icons.search,
                          size: 26,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.more_vert_rounded,
                          size: 28,
                          color: Colors.black,
                        ),
                      ])
                    ],
                  ),
                ),
                Line()
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
