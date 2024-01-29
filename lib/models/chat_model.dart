import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:upmatev2/models/user_model.dart';
import 'package:upmatev2/repositories/auth.dart';

class ChatModel {
  DocumentReference _ref;
  bool _isGroup;
  String _title;
  String _last_message;
  DateTime? _last_message_time;
  List<DocumentReference<Map<String, dynamic>>> _users_raw;
  List<UserModel>? _users;

  ChatModel({
    required DocumentReference ref,
    bool isGroup = false,
    String title = '',
    required String lastMessage,
    required DateTime? lastMessageTime,
    required List<DocumentReference<Map<String, dynamic>>> usersRaw,
    List<UserModel>? users,
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

    return ChatModel(
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
    List<UserModel> users = [];

    for (var reference in references) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .withConverter(
              fromFirestore: UserModel.fromFirestore,
              toFirestore: (UserModel user, _) => user.toFirestore())
          .doc(reference.id)
          .get();

      users.add(snapshot.data() as UserModel);
    }
    _users = users;
    if (kDebugMode) {
      print("USERS_REFERENCES: $_users");
    }
  }

  DocumentReference get ref => _ref;
  String get title => _title;
  bool get isGroup => _isGroup;
  List<UserModel>? get users => _users;
  List<DocumentReference<Map<String, dynamic>>> get userRaw => _users_raw;
  UserModel? get chatRecipient => _users?.where((element) => element.uid != Auth().getCurrentUserReference().id).single;
  String get lastMessage => _last_message;
  String? get lastMessageTime => _last_message_time == null
      ? null
      : DateFormat('H:mm').format(_last_message_time!);
}
