import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:upmatev2/models/comment_model.dart';
import 'package:upmatev2/models/user_model.dart';

class PostModel {
  DocumentReference _ref;
  DocumentReference? _forumRef;
  List<dynamic> _interests;
  String _postDescription;
  List<dynamic>? _postPhotoRaw;
  List<String>? _postPhoto;
  DocumentReference<Map<String, dynamic>> _userRaw;
  UserModel? _user;
  DateTime? _timestamp;
  List<dynamic> _bookmarks;
  List<dynamic> _likes;
  List<CommentModel>? _comments;
  bool _isCover;

  PostModel({
    required DocumentReference ref,
    DocumentReference? forumRef,
    required List<dynamic> interests,
    required String postDescription,
    required DocumentReference<Map<String, dynamic>> userRaw,
    required DateTime? timestamp,
    required List<dynamic> bookmarks,
    required List<dynamic> likes,
    List<dynamic>? postPhotoRaw,
    List<String>? postPhoto,
    bool isCover = false,
  })  : _ref = ref,
        _forumRef = forumRef,
        _interests = interests,
        _postDescription = postDescription,
        _userRaw = userRaw,
        _timestamp = timestamp,
        _bookmarks = bookmarks,
        _likes = likes,
        _postPhotoRaw = postPhotoRaw,
        _postPhoto = postPhoto,
        _isCover = isCover;

  factory PostModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    debugPrint("snasopt post: $data");
    List<dynamic> dataListPhoto =  (data?['post_photo'] is String)
        ? [data?['post_photo']]
        : data?['post_photo'] ?? [];

    return PostModel(
        ref: snapshot.reference,
        forumRef: data?['forumRef'],
        interests: data?['interests'] ?? [],
        postDescription: data?['post_description'] ?? '',
        userRaw: data?['post_user'],
        timestamp: (data?['timestamp'] as Timestamp?)?.toDate(),
        bookmarks: data?['bookmarks'] ?? [],
        likes: data?['likes'] ?? [],
        postPhotoRaw: dataListPhoto,
        isCover: data?['isCover'] ?? false);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "forumRef": _forumRef,
      "interests": _interests,
      "post_description": _postDescription,
      "post_user": _user?.ref,
      "timestamp": _timestamp,
      "bookmarks": _bookmarks,
      "likes": _likes,
      "post_photo": _postPhoto,
      "isCover": _isCover
    };
  }

  Future<void> initUsers() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (UserModel user, _) => user.toFirestore())
        .doc(_userRaw.id)
        .get();
    _user = snapshot.data() as UserModel?;
  }

  Future<void> initPhotos() async {
    List<String>? photoListString = _postPhotoRaw?.map((dynamic item) => item.toString()).toList();
    _postPhoto = photoListString;
  }

  Future<void> getComment() async {
    List<CommentModel> comments = [];
    QuerySnapshot querySnapshots = await _ref
        .collection("comments")
        .withConverter(
            fromFirestore: CommentModel.fromFirestore,
            toFirestore: (CommentModel comment, _) => comment.toFirestore())
        .get();

    for (var e in querySnapshots.docs) {
      comments.add(e.data() as CommentModel);
    }
    _comments = comments;
  }

  void toggleLike() {
    var thisUser = FirebaseAuth.instance.currentUser;

    _ref.update({
      "likes": (likes.contains(thisUser))
          ? FieldValue.arrayUnion([thisUser])
          : FieldValue.arrayRemove([thisUser])
    });
    if (likes.contains(thisUser)) {
      likes.remove(thisUser);
    } else {
      likes.add(thisUser);
    }
  }

  void toggleBookmark() {
    var thisUser = FirebaseAuth.instance.currentUser;
    _ref.update({
      "bookmarks": (bookmarks.contains(thisUser))
          ? FieldValue.arrayUnion([thisUser])
          : FieldValue.arrayRemove([thisUser])
    });
    if (bookmarks.contains(thisUser)) {
      bookmarks.remove(thisUser);
    } else {
      bookmarks.add(thisUser);
    }
  }

  Future<void> update({
    DocumentReference? forumRef,
    List<dynamic>? interests,
    String? postDescription,
    String? postTitle,
    DocumentReference<Map<String, dynamic>>? userRaw,
    DateTime? timestamp,
    List<dynamic>? bookmarks,
    List<dynamic>? likes,
    String? postPhoto,
    bool? isCover,
  }) async {
    final Map<String, dynamic> updatedData = {};

    if (forumRef != null) updatedData['forumRef'] = forumRef;
    if (interests != null) updatedData['interests'] = interests;
    if (postDescription != null) {
      updatedData['post_description'] = postDescription;
    }
    if (postTitle != null) updatedData['post_title'] = postTitle;
    if (userRaw != null) updatedData['post_user'] = userRaw;
    if (timestamp != null) updatedData['timestamp'] = timestamp;
    if (bookmarks != null) updatedData['bookmarks'] = bookmarks;
    if (likes != null) updatedData['likes'] = likes;
    if (postPhoto != null) updatedData['post_photo'] = postPhoto;
    if (isCover != null) updatedData['isCover'] = isCover;

    if (updatedData.isNotEmpty) {
      await _ref.update(updatedData);
      _updateLocalFields(updatedData);
    }
  }

  void _updateLocalFields(Map<String, dynamic> updatedData) {
    if (updatedData.containsKey('forumRef')) {
      _forumRef = updatedData['forumRef'];
    }
    if (updatedData.containsKey('interests')) {
      _interests = updatedData['interests'];
    }
    if (updatedData.containsKey('post_description')) {
      _postDescription = updatedData['post_description'];
    }
    if (updatedData.containsKey('post_user')) {
      _userRaw = updatedData['post_user'];
    }
    if (updatedData.containsKey('timestamp')) {
      _timestamp = updatedData['timestamp'];
    }
    if (updatedData.containsKey('bookmarks')) {
      _bookmarks = updatedData['bookmarks'];
    }
    if (updatedData.containsKey('likes')) _likes = updatedData['likes'];
    if (updatedData.containsKey('post_photo')) {
      _postPhoto = updatedData['post_photo'];
    }
    if (updatedData.containsKey('isCover')) _isCover = updatedData['isCover'];
  }

  DocumentReference get ref => _ref;

  DocumentReference? get forumRef => _forumRef;

  UserModel? get user => _user;

  List<dynamic> get interests => _interests;

  String get postDescription => _postDescription;

  DateTime? get timestamp => _timestamp;

  List get bookmarks => _bookmarks;

  List get likes => _likes;

  List<CommentModel>? get comments => _comments;

  bool get isCover => _isCover;

  List<String>? get postPhoto => _postPhoto;

  String? get userPhoto => _user?.photoUrl;
}
