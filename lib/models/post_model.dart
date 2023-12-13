import 'package:cloud_firestore/cloud_firestore.dart';
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
  DateTime _timestamp;
  List<DocumentReference> _bookmarks;
  List<DocumentReference> _likes;

  PostModel._(
      {required DocumentReference ref,
      DocumentReference? forumRef,
      required List<dynamic> interests,
      required String postDescription,
      required String postTitle,
      required DocumentReference<Map<String, dynamic>> userRaw,
      required DateTime timestamp,
      required List<DocumentReference> bookmarks,
      required List<DocumentReference> likes,
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
      timestamp: (data?['timestamp'] as Timestamp).toDate(),
      bookmarks: data?['bookmarks'] ?? [],
      likes: data?['likes'] ?? [],
      postPhoto: data?['post_photo'] ?? ""
    );
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

  DocumentReference get ref => _ref;
  DocumentReference? get forumRef => _forumRef;
  UserModel? get user => _user;
  List<dynamic> get interests => _interests;
  String get postDescription => _postDescription;
  String get postTitle => _postTitle;
  DateTime get timestamp => _timestamp;
  List<DocumentReference> get bookmarks => _bookmarks;
  List<DocumentReference> get likes => _likes;
}
