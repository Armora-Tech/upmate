import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/post_model.dart';
import '../utils/upload.dart';
import 'auth.dart';

class UserRepository {
  final Auth _auth = Auth();

  Future<List<PostModel>?> getUserPosts(
      {DocumentReference? userRef = null}) async {
    List<PostModel> posts = [];
    userRef ??= _auth.getCurrentUserReference();
    QuerySnapshot querySnapshots = await FirebaseFirestore.instance
        .collection("posts")
        .where("post_user", isEqualTo: userRef.id)
        .orderBy("timestamp", descending: true)
        .withConverter(
            fromFirestore: PostModel.fromFirestore,
            toFirestore: (PostModel post, _) => post.toFirestore())
        .get();

    for (var e in querySnapshots.docs) {
      var td = e.data() as PostModel;
      await td.initPhotos();
      await td.initUsers();
      await td.getComment();
      posts.add(td);
    }
    return posts;
  }

  Future<List<PostModel>?> getBookmarks() async {
    List<PostModel> posts = [];
    QuerySnapshot querySnapshots = await FirebaseFirestore.instance
        .collection("posts")
        .where("bookmarks", arrayContains: _auth.getCurrentUserReference().id)
        .orderBy("timestamp", descending: true)
        .withConverter(
            fromFirestore: PostModel.fromFirestore,
            toFirestore: (PostModel post, _) => post.toFirestore())
        .get();

    for (var e in querySnapshots.docs) {
      var td = e.data() as PostModel;
      await td.initPhotos();
      await td.initUsers();
      await td.getComment();
      posts.add(td);
    }
    return posts;
  }

  Future<void> updateBanner(File asset) async {
    final userModel = await _auth.getUserModel();
    Map<String, dynamic> data = <String, dynamic>{};
    try {
      final response = await Upload().uploadImage(asset);
      if (response.statusCode == 200) {
        final responseData = response.body;
        final jsonResponse = jsonDecode(responseData);
        data["banner_url"] = (jsonResponse['url']);
        await _auth
            .getCurrentUserReference()
            .update(data)
            .whenComplete(() => print("data updated"))
            .catchError((e) => print(e));
        userModel?.bannerUrl = data["banner_url"];
      } else {
        //error
        return;
      }
    } catch (error) {
      return;
    }
  }

  Future<void> updateProfile(File asset) async {
    final userModel = await _auth.getUserModel();
    Map<String, dynamic> data = <String, dynamic>{};
    try {
      final response = await Upload().uploadImage(asset);
      if (response.statusCode == 200) {
        final responseData = response.body;
        final jsonResponse = jsonDecode(responseData);
        data["photo_url"] = (jsonResponse['url']);
        await _auth
            .getCurrentUserReference()
            .update(data)
            .whenComplete(() => print("data updated"))
            .catchError((e) => print(e));
        userModel?.photoUrl = data["photo_url"];
      } else {
        //error
        return;
      }
    } catch (error) {
      return;
    }
  }

  Future<void> updateBio(String bio) async {
    final userModel = await _auth.getUserModel();
    Map<String, dynamic> data = <String, dynamic>{};
    data["bio"] = bio;
    await _auth
        .getCurrentUserReference()
        .update(data)
        .whenComplete(() => print("data updated"))
        .catchError((e) => print(e));
    userModel?.bio = data["bio"];
  }

  Future<void> updateEmail(String newEmail) async {
    FirebaseAuth.instance.currentUser?.updateEmail(newEmail);
    final userModel = await _auth.getUserModel();
    Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = newEmail;
    await _auth
        .getCurrentUserReference()
        .update(data)
        .whenComplete(() => print("data updated"))
        .catchError((e) => print(e));
    userModel?.email = data["email"];
  }
}
