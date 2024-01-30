import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:upmatev2/models/comment_model.dart';

import '../models/post_model.dart';
import '../models/user_model.dart';
import 'auth.dart';

class PostRepository {
  final Auth _auth = Auth();
  QueryDocumentSnapshot<PostModel>? lastPost;

  Future<void> addPost(PostModel postModel) async {
    try {
      await FirebaseFirestore.instance
          .collection("posts")
          .add(postModel.toFirestore())
          .then(
            (DocumentReference doc) => {
              if (kDebugMode)
                {debugPrint('DocumentSnapshot added with ID: ${doc.id}')}
            },
          );
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

  Future<void> addComment(CommentModel commentModel) async {
    try {
      await FirebaseFirestore.instance
          .collection("comments")
          .add(commentModel.toFirestore())
          .then(
            (DocumentReference doc) => {
              if (kDebugMode)
                {debugPrint('DocumentSnapshot added with ID: ${doc.id}')}
            },
          );
    } catch (e) {
      debugPrint("ERROR : $e");
    }
  }

  Stream<List<dynamic>> getLikesStream(DocumentReference postRef) {
    return postRef
        .withConverter(
            fromFirestore: PostModel.fromFirestore,
            toFirestore: (PostModel post, _) => post.toFirestore())
        .snapshots()
        .asyncMap((post) async {
      var postData = post.data() as PostModel;
      await postData.getComment();

      return postData.likes;
    });
  }

  Stream<List<dynamic>> getBookmarksStream(DocumentReference postRef) {
    return postRef
        .withConverter(
            fromFirestore: PostModel.fromFirestore,
            toFirestore: (PostModel post, _) => post.toFirestore())
        .snapshots()
        .asyncMap((post) async {
      var postData = post.data() as PostModel;
      await postData.getComment();

      return postData.bookmarks;
    });
  }

  Stream<List<CommentModel>?> getCommentsStream(DocumentReference postRef) {
    return postRef
        .withConverter(
            fromFirestore: PostModel.fromFirestore,
            toFirestore: (PostModel post, _) => post.toFirestore())
        .snapshots()
        .asyncMap((post) async {
      var postData = post.data() as PostModel;
      await postData.getComment();

      return postData.comments;
    });
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
          .limit(5)
          .withConverter(
              fromFirestore: PostModel.fromFirestore,
              toFirestore: (PostModel post, _) => post.toFirestore())
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        lastPost = querySnapshot.docs[querySnapshot.docs.length - 1]
        as QueryDocumentSnapshot<PostModel>;
        final lastPostData = lastPost!.data();
        await lastPostData.initUsers();
        await lastPostData.initPhotos();
        await lastPostData.getComment();

        for (var e in querySnapshot.docs) {
          var post = e.data() as PostModel;
          await post.initUsers();
          await post.initPhotos();
          await post.getComment();

          if (kDebugMode) {
            print(post);
            print("PostModel: ${post.interests}");
            debugPrint("Likes: ${post.likes}");
            if (post.comments!.isNotEmpty) {
              print("Comment: ${post.comments?[0].text}");
            }
          }
          if (post.timestamp != null) {
            data.add(post);
          }
        }
        return data;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PostModel>> getMorePosts() async {
    try {
      UserModel? currentUser = await _auth.getUserModel();
      List<PostModel> data = [];
      debugPrint("Interest: ${currentUser?.interests}");
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .where('interests', arrayContainsAny: currentUser?.interests)
          .orderBy("timestamp", descending: true)
          .startAfterDocument(lastPost!)
          .limit(2)
          .withConverter(
              fromFirestore: PostModel.fromFirestore,
              toFirestore: (PostModel post, _) => post.toFirestore())
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        lastPost = querySnapshot.docs[querySnapshot.docs.length - 1]
            as QueryDocumentSnapshot<PostModel>;
        final lastPostData = lastPost!.data();
        await lastPostData.initUsers();
        await lastPostData.initPhotos();
        await lastPostData.getComment();
        for (var e in querySnapshot.docs) {
          var post = e.data() as PostModel;
          await post.initUsers();
          await post.initPhotos();
          await post.getComment();

          if (kDebugMode) {
            print(post);
            print("PostModel: ${post.interests}");
            debugPrint("Likes: ${post.likes}");
            if (post.comments!.isNotEmpty) {
              print("Comment: ${post.comments?[0].text}");
            }
          }
          if (post.timestamp != null) {
            data.add(post);
          }
        }
        return data;
      }
      return [];
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
