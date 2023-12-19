import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/models/user_model.dart';
import '../models/post_model.dart';
import '../utils/auth.dart';

class HomeController extends GetxController {
  final Auth _auth = Auth();
  RxInt selectedIndex = 0.obs;
  RxString fullText =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
          .obs;
  RxBool isFullText = false.obs;

  final Map<String, dynamic>  action = {
    "90": Icons.share_outlined,
    "120": Icons.bookmark_outline_rounded,
    "6": Icons.chat_bubble_outline_rounded,
    "1.3k": Icons.favorite_border_rounded
  };

  final List<String> images = [
    "assets/images/naruto.jpg",
    "assets/images/quran.png",
    "assets/images/gojek.png",
    "assets/images/movie-app.png",
    "assets/images/jkt-app.png",
  ];

  String handleText(String text) {
    if (isFullText.value) {
      return text;
    } else {
      if (text.length > 80) {
        return "${text.substring(0, 80)}...";
      }
    }
    return text;
  }

  Future<List<PostModel>> getPosts() async {
    try {
      UserModel? currentUser = await _auth.getUserModel();
      List<PostModel> data = [];

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .where('interests', arrayContainsAny: currentUser?.interests)
          .withConverter(
              fromFirestore: PostModel.fromFirestore,
              toFirestore: (PostModel post, _) => post.toFirestore())
          .get();

      for(var e in querySnapshot.docs){
        var post = e.data() as PostModel;
        await post.initUsers();
        await post.getComment();

        if (kDebugMode) {
          print("PostModel: ${post.interests}");
          print("Likes: ${post.likes}");
          if(post.comments!.isNotEmpty) {
            print("Comment: ${post.comments?[0].text}");
          }
        }
        data.add(post);
      }
      return data;
    } catch (e) {
      print("ERROR: $e");
      return [];
    }
  }

}
