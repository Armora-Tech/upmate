import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  DocumentReference _ref;
  DateTime? _created_time;
  String _display_name;
  String _email;
  List<dynamic> _interests;
  String _uid;
  String _username;

  UserModel._(
      {required DocumentReference ref,
      required DateTime? createdTime,
      required String displayName,
      required String email,
      required List<dynamic> interests,
      required String uid,
      required String username})
      : _ref = ref,
        _created_time = createdTime,
        _display_name = displayName,
        _email = email,
        _interests = interests,
        _uid = uid,
        _username = username;

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
      username: data?['username'] ?? ''
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "created_time": _created_time,
      "display_name": _display_name,
      "email": _email,
      "interests": _interests,
      "uid": _uid,
      "username": _username
    };
  }

  DocumentReference get ref => _ref;
  String get uid => _uid;
  String get displayName => _display_name;
  List get interests => _interests;
  String get email => _email;
  String get username => _username;
}
