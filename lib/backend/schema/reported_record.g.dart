// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reported_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ReportedRecord> _$reportedRecordSerializer =
    new _$ReportedRecordSerializer();

class _$ReportedRecordSerializer
    implements StructuredSerializer<ReportedRecord> {
  @override
  final Iterable<Type> types = const [ReportedRecord, _$ReportedRecord];
  @override
  final String wireName = 'ReportedRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, ReportedRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.reporter;
    if (value != null) {
      result
        ..add('reporter')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.reported;
    if (value != null) {
      result
        ..add('reported')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.what;
    if (value != null) {
      result
        ..add('what')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.userRef;
    if (value != null) {
      result
        ..add('userRef')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.postRef;
    if (value != null) {
      result
        ..add('postRef')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.commentRef;
    if (value != null) {
      result
        ..add('commentRef')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  ReportedRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReportedRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'reporter':
          result.reporter = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'reported':
          result.reported = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'what':
          result.what = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'userRef':
          result.userRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'postRef':
          result.postRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'commentRef':
          result.commentRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$ReportedRecord extends ReportedRecord {
  @override
  final DocumentReference<Object?>? reporter;
  @override
  final DocumentReference<Object?>? reported;
  @override
  final String? what;
  @override
  final DocumentReference<Object?>? userRef;
  @override
  final DocumentReference<Object?>? postRef;
  @override
  final DocumentReference<Object?>? commentRef;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$ReportedRecord([void Function(ReportedRecordBuilder)? updates]) =>
      (new ReportedRecordBuilder()..update(updates))._build();

  _$ReportedRecord._(
      {this.reporter,
      this.reported,
      this.what,
      this.userRef,
      this.postRef,
      this.commentRef,
      this.ffRef})
      : super._();

  @override
  ReportedRecord rebuild(void Function(ReportedRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReportedRecordBuilder toBuilder() =>
      new ReportedRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReportedRecord &&
        reporter == other.reporter &&
        reported == other.reported &&
        what == other.what &&
        userRef == other.userRef &&
        postRef == other.postRef &&
        commentRef == other.commentRef &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reporter.hashCode);
    _$hash = $jc(_$hash, reported.hashCode);
    _$hash = $jc(_$hash, what.hashCode);
    _$hash = $jc(_$hash, userRef.hashCode);
    _$hash = $jc(_$hash, postRef.hashCode);
    _$hash = $jc(_$hash, commentRef.hashCode);
    _$hash = $jc(_$hash, ffRef.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReportedRecord')
          ..add('reporter', reporter)
          ..add('reported', reported)
          ..add('what', what)
          ..add('userRef', userRef)
          ..add('postRef', postRef)
          ..add('commentRef', commentRef)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class ReportedRecordBuilder
    implements Builder<ReportedRecord, ReportedRecordBuilder> {
  _$ReportedRecord? _$v;

  DocumentReference<Object?>? _reporter;
  DocumentReference<Object?>? get reporter => _$this._reporter;
  set reporter(DocumentReference<Object?>? reporter) =>
      _$this._reporter = reporter;

  DocumentReference<Object?>? _reported;
  DocumentReference<Object?>? get reported => _$this._reported;
  set reported(DocumentReference<Object?>? reported) =>
      _$this._reported = reported;

  String? _what;
  String? get what => _$this._what;
  set what(String? what) => _$this._what = what;

  DocumentReference<Object?>? _userRef;
  DocumentReference<Object?>? get userRef => _$this._userRef;
  set userRef(DocumentReference<Object?>? userRef) => _$this._userRef = userRef;

  DocumentReference<Object?>? _postRef;
  DocumentReference<Object?>? get postRef => _$this._postRef;
  set postRef(DocumentReference<Object?>? postRef) => _$this._postRef = postRef;

  DocumentReference<Object?>? _commentRef;
  DocumentReference<Object?>? get commentRef => _$this._commentRef;
  set commentRef(DocumentReference<Object?>? commentRef) =>
      _$this._commentRef = commentRef;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  ReportedRecordBuilder() {
    ReportedRecord._initializeBuilder(this);
  }

  ReportedRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reporter = $v.reporter;
      _reported = $v.reported;
      _what = $v.what;
      _userRef = $v.userRef;
      _postRef = $v.postRef;
      _commentRef = $v.commentRef;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReportedRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReportedRecord;
  }

  @override
  void update(void Function(ReportedRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReportedRecord build() => _build();

  _$ReportedRecord _build() {
    final _$result = _$v ??
        new _$ReportedRecord._(
            reporter: reporter,
            reported: reported,
            what: what,
            userRef: userRef,
            postRef: postRef,
            commentRef: commentRef,
            ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
