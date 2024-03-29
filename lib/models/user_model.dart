import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:upmatev2/models/post_model.dart';

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
  String? _bio;

  UserModel(
      {required DocumentReference ref,
      required DateTime? createdTime,
      required String displayName,
      required String email,
      required List<dynamic> interests,
      required String uid,
      required String username,
      String? photoUrl,
      String? bannerUrl,
      String? bio})
      : _ref = ref,
        _created_time = createdTime,
        _display_name = displayName,
        _email = email,
        _interests = interests,
        _uid = uid,
        _username = username,
        _photo_url = photoUrl,
        _banner_url = bannerUrl,
        _bio = bio;

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return UserModel(
        ref: snapshot.reference,
        createdTime: (data?['created_time'] as Timestamp?)?.toDate(),
        displayName: data?['display_name'] ?? '',
        email: data?['email'] ?? '',
        interests: data?['interests'] ?? [],
        uid: data?['uid'] ?? '',
        username: data?['display_name'] == null
            ? ""
            : "@${data?['display_name'].replaceAll(" ", "").toLowerCase()}",
        photoUrl: data?['photo_url'] ??
            "https://t3.ftcdn.net/jpg/00/64/67/80/360_F_64678017_zUpiZFjj04cnLri7oADnyMH0XBYyQghG.jpg",
        bannerUrl: data?['banner_url'],
        bio: data?['bio']);
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
      "banner_url": _banner_url,
      "bio": _bio
    };
  }

  DocumentReference get ref => _ref;

  String get uid => _uid;

  List<PostModel>? get posts => _posts;

  set posts(List<PostModel>? newPosts) {
    _posts = newPosts;
  }

  String get displayName => _display_name;

  List get interests => _interests;

  String get email => _email;
  set email(String newEmail) {
    _email = newEmail;
  }

  String get username => _username;

  String? get photoUrl => _photo_url;

  set photoUrl(String? newUrl) {
    _photo_url = newUrl;
  }

  String? get bannerUrl => _banner_url;

  set bannerUrl(String? newUrl) {
    _banner_url = newUrl;
  }

  String? get bio => _bio;
  set bio(String? newBio) {
    _bio = newBio;
  }
}
