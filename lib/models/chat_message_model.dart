import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageModel {
  DocumentReference _ref;
  DocumentReference _chat;
  String _text;
  DateTime _timestamp;
  DocumentReference _user;

  ChatMessageModel._({
    required DocumentReference ref,
    required DocumentReference chat,
    required String text,
    required DateTime timestamp,
    required DocumentReference user,
  })  : _ref = ref,
        _chat = chat,
        _text = text,
        _timestamp = timestamp,
        _user = user;

  factory ChatMessageModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();

    return ChatMessageModel._(
      ref: snapshot.reference,
      chat: data?['chat'],
      text: data?['text'],
      timestamp: (data?['timestamp'] as Timestamp?)!.toDate(),
      user: data?['user']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "chat": _chat,
      "text": _text,
      "timestamp": _timestamp,
      "user": _user
    };
  }

  DocumentReference get ref => _ref;
  DocumentReference get chatRef => _chat;
  String get text => _text;
  DateTime get timestamp => _timestamp;
  DocumentReference get owner => _user;
}
