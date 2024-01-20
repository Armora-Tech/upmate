import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/post_model.dart';
import '../models/user_model.dart';
import 'auth.dart';

class PostRepository {
  final Auth _auth = Auth();

  Future<void> addPost(PostModel postModel) async {
    try {
      await FirebaseFirestore.instance
          .collection("posts")
          .add(postModel.toFirestore())
          .then((DocumentReference doc) => {
                if (kDebugMode)
                  {debugPrint('DocumentSnapshot added with ID: ${doc.id}')}
              });
    } catch (e) {
      debugPrint("ERROR POsTing : $e");
    }
  }

  Future<void> deletePost(String docRefID) async {
    try {
      await FirebaseFirestore.instance.doc(docRefID).delete().then(
            (doc) => debugPrint("Document deleted"),
            onError: (e) => debugPrint("Error updating document $e"),
          );
    } catch (e) {
      debugPrint("ERROR : $e");
    }
  }

  Future<List<PostModel>> getPosts() async {
    try {
      UserModel? currentUser = await _auth.getUserModel();
      List<PostModel> data = [];
      debugPrint("Interest: ${currentUser?.interests}");
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .where('interests', arrayContainsAny: currentUser?.interests)
          .orderBy("timestamp", descending: true)
          .withConverter(
              fromFirestore: PostModel.fromFirestore,
              toFirestore: (PostModel post, _) => post.toFirestore())
          .get();

      for (var e in querySnapshot.docs) {
        var post = e.data() as PostModel;
        await post.initUsers();
        await post.initPhotos();
        await post.getComment();

        if (kDebugMode) {
          print(post);
          print("PostModel: ${post.interests}");
          print("Likes: ${post.likes}");
          if (post.comments!.isNotEmpty) {
            print("Comment: ${post.comments?[0].text}");
          }
        }
        if (post.timestamp != null) {
          data.add(post);
        }
      }
      return data;
    } catch (e) {
      rethrow;
      print("ERROR, postrepo: $e");
      return [];
    }
  }
}
