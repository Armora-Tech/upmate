import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:upmatev2/models/post_model.dart';

import '../utils/upload.dart';

class UserModel {
  DocumentReference _ref;
  DateTime? _created_time;
  String _display_name;
  String _email;
  List<dynamic> _interests;
  String _uid;
  String _username;
  String? _photo_url;
  List<PostModel>? _posts;
  String? _banner_url;

  UserModel._(
      {required DocumentReference ref,
      required DateTime? createdTime,
      required String displayName,
      required String email,
      required List<dynamic> interests,
      required String uid,
      required String username,
      String? photoUrl,
      String? bannerUrl})
      : _ref = ref,
        _created_time = createdTime,
        _display_name = displayName,
        _email = email,
        _interests = interests,
        _uid = uid,
        _username = username,
        _photo_url = photoUrl,
        _banner_url = bannerUrl;

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return UserModel._(
        ref: snapshot.reference,
        createdTime: (data?['created_time'] as Timestamp?)?.toDate(),
        displayName: data?['display_name'] ?? '',
        email: data?['email'] ?? '',
        interests: data?['interests'] ?? [],
        uid: data?['uid'] ?? '',
        username: data?['username'] ??
            "@${data?['display_name'].replaceAll(" ", "").toLowerCase()}",
        photoUrl: data?['photo_url'] ??
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-Pnt1rnG5_oeghvwAVvVBhcLrR5yZRqLRFw&usqp=CAU",
        bannerUrl: data?['banner_url']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "created_time": _created_time,
      "display_name": _display_name,
      "email": _email,
      "interests": _interests,
      "uid": _uid,
      "username": _username,
      "photo_url": _photo_url,
      "banner_url": _banner_url
    };
  }

  Future<void> getPosts() async {
    List<PostModel> posts = [];
    QuerySnapshot querySnapshots = await FirebaseFirestore.instance
        .collection("posts")
        .where("post_user", isEqualTo: _ref.id)
        .withConverter(
            fromFirestore: PostModel.fromFirestore,
            toFirestore: (PostModel post, _) => post.toFirestore())
        .get();

    for (var e in querySnapshots.docs) {
      var td=e.data() as PostModel;
      await td.initPhotos();
      posts.add(td);
    }
    _posts = posts;
  }

  Future<void> updateBanner(File asset) async {
    Map<String, dynamic> data = <String, dynamic>{};
    try {
      final response = await Upload().uploadImage(asset);
      if (response.statusCode == 200) {
        final responseData = response.body;
        final jsonResponse = jsonDecode(responseData);
        data["banner_url"] = (jsonResponse['url']);
        await _ref
            .update(data)
            .whenComplete(() => print("data updated"))
            .catchError((e) => print(e));
        _banner_url = data["banner_url"];
      } else {
        //error
        return;
      }
    } catch (error) {
      return;
    }
  }

  Future<void> updateProfile(File asset) async {
    Map<String, dynamic> data = <String, dynamic>{};
    try {
      final response = await Upload().uploadImage(asset);
      if (response.statusCode == 200) {
        final responseData = response.body;
        final jsonResponse = jsonDecode(responseData);
        data["photo_url"] = (jsonResponse['url']);
        await _ref
            .update(data)
            .whenComplete(() => print("data updated"))
            .catchError((e) => print(e));
        _photo_url = data["photo_url"];
      } else {
        //error
        return;
      }
    } catch (error) {
      return;
    }
  }

  DocumentReference get ref => _ref;

  String get uid => _uid;

  String get displayName => _display_name;

  List get interests => _interests;

  String get email => _email;

  String get username => _username;

  List<PostModel>? get posts => _posts;

  String? get photoUrl => _photo_url;

  String? get bannerUrl => _banner_url;
}
