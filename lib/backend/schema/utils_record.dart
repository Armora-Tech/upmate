import 'dart:async';

import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'utils_record.g.dart';

abstract class UtilsRecord implements Built<UtilsRecord, UtilsRecordBuilder> {
  static Serializer<UtilsRecord> get serializer => _$utilsRecordSerializer;

  BuiltList<String>? get joblist;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(UtilsRecordBuilder builder) =>
      builder..joblist = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('utils');

  static Stream<UtilsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<UtilsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  UtilsRecord._();
  factory UtilsRecord([void Function(UtilsRecordBuilder) updates]) =
      _$UtilsRecord;

  static UtilsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createUtilsRecordData() {
  final firestoreData = serializers.toFirestore(
    UtilsRecord.serializer,
    UtilsRecord(
      (u) => u..joblist = null,
    ),
  );

  return firestoreData;
}
