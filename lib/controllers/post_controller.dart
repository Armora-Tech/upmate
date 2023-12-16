import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:upmatev2/models/post_model.dart';

class PostController extends GetxController {
  late TextEditingController description;
  late FocusNode focusNode;
  RxBool isCover = false.obs;

  @override
  void onInit() {
    focusNode = FocusNode();
    description = TextEditingController();
    focusNode.addListener(() {});
    update();
    super.onInit();
  }

  @override
  void dispose() {
    focusNode.dispose();
    description.dispose();
    super.dispose();
  }

  Future<void> addPost(PostModel postModel) async {
    await FirebaseFirestore.instance
        .collection("posts")
        .add(postModel.toFirestore())
        .then((DocumentReference doc) => {
              if (kDebugMode)
                {print('DocumentSnapshot added with ID: ${doc.id}')}
            });
  }

  Future<void> deletePost(String docRefID) async {
    await FirebaseFirestore.instance.doc(docRefID).delete().then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }
}
