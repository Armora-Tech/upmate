import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ChatModel {
  DocumentReference _ref;
  bool _isGroup;
  String _title;
  String _last_message;
  DateTime? _last_message_time;
  List<DocumentReference<Map<String, dynamic>>> _users_raw;
  List<User>? _users;

  ChatModel._({
    required DocumentReference ref,
    bool isGroup = false,
    String title = '',
    required String lastMessage,
    required DateTime? lastMessageTime,
    required List<DocumentReference<Map<String, dynamic>>> usersRaw,
    List<User>? users,
  })  : _ref = ref,
        _isGroup = isGroup,
        _title = title,
        _last_message = lastMessage,
        _last_message_time = lastMessageTime,
        _users_raw = usersRaw,
        _users = users;

  factory ChatModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    final List<dynamic> usersData = data?['users'] ?? [];

    List<DocumentReference<Map<String, dynamic>>> users = usersData
        .map((userRef) => userRef as DocumentReference<Map<String, dynamic>>)
        .toList();

    return ChatModel._(
      ref: snapshot.reference,
      isGroup: data?['isGroup'] ?? false,
      title: data?['title'] ?? '',
      lastMessage: data?['last_message'] ?? '',
      lastMessageTime: (data?['last_message_time'] as Timestamp?)?.toDate(),
      usersRaw: users,
    );
  }

  Future<void> initUsers() async {
    await getUsersFromReferences(_users_raw);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "isGroup": _isGroup,
      "title": _title,
      "last_message": _last_message,
      "last_message_time": _last_message_time,
      "users": _users_raw,
    };
  }

  Future<void> getUsersFromReferences(
      List<DocumentReference<Map<String, dynamic>>> references) async {
    List<User> users = [];

    for (DocumentReference<Map<String, dynamic>> reference in references) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await reference.get();

      if (snapshot.exists) {
        // Convert the DocumentSnapshot to a User and add to the list
        User user = FirebaseAuth.instance.currentUser!;
        users.add(user);
      }
    }

    _users = users;
    if (kDebugMode) {
      print("USERS: $_users");
    }
  }

  DocumentReference get ref => _ref;

  String get title => _title;

  bool get isGroup => _isGroup;

  List<User>? get users => _users;

  String get lastMessage => _last_message;
}
