import 'dart:async';

import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'ratings_record.g.dart';

abstract class RatingsRecord
    implements Built<RatingsRecord, RatingsRecordBuilder> {
  static Serializer<RatingsRecord> get serializer => _$ratingsRecordSerializer;

  int? get star;

  String? get comment;

  DocumentReference? get user;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(RatingsRecordBuilder builder) => builder
    ..star = 0
    ..comment = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ratings');

  static Stream<RatingsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<RatingsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  RatingsRecord._();
  factory RatingsRecord([void Function(RatingsRecordBuilder) updates]) =
      _$RatingsRecord;

  static RatingsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createRatingsRecordData({
  int? star,
  String? comment,
  DocumentReference? user,
}) {
  final firestoreData = serializers.toFirestore(
    RatingsRecord.serializer,
    RatingsRecord(
      (r) => r
        ..star = star
        ..comment = comment
        ..user = user,
    ),
  );

  return firestoreData;
}
