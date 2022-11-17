import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'reported_record.g.dart';

abstract class ReportedRecord
    implements Built<ReportedRecord, ReportedRecordBuilder> {
  static Serializer<ReportedRecord> get serializer =>
      _$reportedRecordSerializer;

  DocumentReference? get reporter;

  DocumentReference? get reported;

  String? get what;

  DocumentReference? get userRef;

  DocumentReference? get postRef;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(ReportedRecordBuilder builder) =>
      builder..what = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('reported');

  static Stream<ReportedRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<ReportedRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  ReportedRecord._();
  factory ReportedRecord([void Function(ReportedRecordBuilder) updates]) =
      _$ReportedRecord;

  static ReportedRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createReportedRecordData({
  DocumentReference? reporter,
  DocumentReference? reported,
  String? what,
  DocumentReference? userRef,
  DocumentReference? postRef,
}) {
  final firestoreData = serializers.toFirestore(
    ReportedRecord.serializer,
    ReportedRecord(
      (r) => r
        ..reporter = reporter
        ..reported = reported
        ..what = what
        ..userRef = userRef
        ..postRef = postRef,
    ),
  );

  return firestoreData;
}
