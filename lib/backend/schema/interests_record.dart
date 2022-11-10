import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'interests_record.g.dart';

abstract class InterestsRecord
    implements Built<InterestsRecord, InterestsRecordBuilder> {
  static Serializer<InterestsRecord> get serializer =>
      _$interestsRecordSerializer;

  String? get name;

  @BuiltValueField(wireName: 'photo_url')
  String? get photoUrl;

  BuiltList<DocumentReference>? get followers;

  BuiltList<int>? get jobs;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(InterestsRecordBuilder builder) => builder
    ..name = ''
    ..photoUrl = ''
    ..followers = ListBuilder()
    ..jobs = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('interests');

  static Stream<InterestsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<InterestsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  InterestsRecord._();
  factory InterestsRecord([void Function(InterestsRecordBuilder) updates]) =
      _$InterestsRecord;

  static InterestsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createInterestsRecordData({
  String? name,
  String? photoUrl,
}) {
  final firestoreData = serializers.toFirestore(
    InterestsRecord.serializer,
    InterestsRecord(
      (i) => i
        ..name = name
        ..photoUrl = photoUrl
        ..followers = null
        ..jobs = null,
    ),
  );

  return firestoreData;
}
