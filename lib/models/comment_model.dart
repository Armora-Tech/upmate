import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:upmatev2/models/user_model.dart';

class CommentModel {
  DocumentReference _ref;
  DateTime _date;
  DocumentReference _postRef;
  String _text;
  DocumentReference _userRef;
  UserModel? _user;

  CommentModel._(
      {required DocumentReference ref,
      required DateTime date,
      required DocumentReference postRef,
      required String text,
      required DocumentReference userRef})
      : _ref = ref,
        _date = date,
        _postRef = postRef,
        _text = text,
        _userRef = userRef;

  factory CommentModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();

    return CommentModel._(
        ref: snapshot.reference,
        date: (data?['date'] as Timestamp?)!.toDate(),
        postRef: data?['post_ref'] ?? '',
        text: data?['text'] ?? '',
        userRef: data?['user_ref'] ?? []
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "date": _date,
      "post_ref": _postRef,
      "text": _text,
      "user_ref": _userRef
    };
  }

  Future<void> initUsers() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .withConverter(
        fromFirestore: UserModel.fromFirestore,
        toFirestore: (UserModel user, _) => user.toFirestore())
        .doc(_userRef.id)
        .get();
    _user = snapshot.data() as UserModel?;
  }

  DocumentReference get ref => _ref;
  DateTime get date => _date;
  DocumentReference get postRef => _postRef;
  String get text => _text;
  UserModel? get user => _user;
}
