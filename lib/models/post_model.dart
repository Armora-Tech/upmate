import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:upmatev2/models/comment_model.dart';
import 'package:upmatev2/models/user_model.dart';

class PostModel {
  DocumentReference _ref;
  DocumentReference? _forumRef;
  List<dynamic> _interests;
  String _postDescription;
  String _postTitle;
  String? _postPhoto;
  DocumentReference<Map<String, dynamic>> _userRaw;
  UserModel? _user;
  DateTime? _timestamp;
  List<dynamic> _bookmarks;
  List<dynamic> _likes;
  List<CommentModel>? _comments;

  PostModel._(
      {required DocumentReference ref,
      DocumentReference? forumRef,
      required List<dynamic> interests,
      required String postDescription,
      required String postTitle,
      required DocumentReference<Map<String, dynamic>> userRaw,
      required DateTime? timestamp,
      required List<dynamic> bookmarks,
      required List<dynamic> likes,
      required String? postPhoto})
      : _ref = ref,
        _forumRef = forumRef,
        _interests = interests,
        _postDescription = postDescription,
        _postTitle = postTitle,
        _userRaw = userRaw,
        _timestamp = timestamp,
        _bookmarks = bookmarks,
        _likes = likes,
        _postPhoto = postPhoto;

  factory PostModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return PostModel._(
        ref: snapshot.reference,
        forumRef: data?['forumRef'],
        interests: data?['interests'] ?? [],
        postDescription: data?['post_description'] ?? '',
        postTitle: data?['post_title'],
        userRaw: data?['post_user'],
        timestamp: (data?['timestamp'] as Timestamp?)?.toDate(),
        bookmarks: data?['bookmarks'] ?? [],
        likes: data?['likes'] ?? [],
        postPhoto: data?['post_photo'] ?? "");
  }

  Map<String, dynamic> toFirestore() {
    return {
      "forumRef": _forumRef,
      "interests": _interests,
      "post_description": _postDescription,
      "post_title": _postTitle,
      "post_user": _user,
      "timestamp": _timestamp,
      "bookmarks": _bookmarks,
      "likes": _likes,
      "post_photo": _postPhoto
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

    _user = snapshot.data() as UserModel;
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

  DocumentReference get ref => _ref;

  DocumentReference? get forumRef => _forumRef;

  UserModel? get user => _user;

  List<dynamic> get interests => _interests;

  String get postDescription => _postDescription;

  String get postTitle => _postTitle;

  DateTime? get timestamp => _timestamp;

  List get bookmarks => _bookmarks;

  List get likes => _likes;

  List<CommentModel>? get comments => _comments;
}
