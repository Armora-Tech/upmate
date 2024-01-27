import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageModel {
  DocumentReference _ref;
  DocumentReference _chat;
  String _text;
  DateTime _timestamp;
  DocumentReference _user;
  String? _image;

  ChatMessageModel({
    required DocumentReference ref,
    required DocumentReference chat,
    required String text,
    required DateTime timestamp,
    required DocumentReference user,
    String? image,
  })  : _ref = ref,
        _chat = chat,
        _text = text,
        _timestamp = timestamp,
        _user = user,
        _image = image;

  factory ChatMessageModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return ChatMessageModel(
        ref: snapshot.reference,
        chat: data?['chat'],
        text: data?['text'],
        timestamp: (data?['timestamp'] as Timestamp?)!.toDate(),
        user: data?['user'],
        image: data?['image']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "chat": _chat,
      "text": _text,
      "timestamp": _timestamp,
      "user": _user,
      "image": _image
    };
  }

  DocumentReference get ref => _ref;

  DocumentReference get chatRef => _chat;

  String get text => _text;

  DateTime get timestamp => _timestamp;

  DocumentReference get owner => _user;

  String? get image => _image;
}
