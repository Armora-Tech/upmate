import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/post_model.dart';

class PostRepository {
  Future<void> addPost(PostModel postModel) async {
    await FirebaseFirestore.instance
        .collection("posts")
        .add(postModel.toFirestore())
        .then((DocumentReference doc) => {
              if (kDebugMode)
                {debugPrint('DocumentSnapshot added with ID: ${doc.id}')}
            });
  }

  Future<void> deletePost(String docRefID) async {
    await FirebaseFirestore.instance.doc(docRefID).delete().then(
          (doc) => debugPrint("Document deleted"),
          onError: (e) => debugPrint("Error updating document $e"),
        );
  }
}
