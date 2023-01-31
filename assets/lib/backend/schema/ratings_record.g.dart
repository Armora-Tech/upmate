// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ratings_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<RatingsRecord> _$ratingsRecordSerializer =
    new _$RatingsRecordSerializer();

class _$RatingsRecordSerializer implements StructuredSerializer<RatingsRecord> {
  @override
  final Iterable<Type> types = const [RatingsRecord, _$RatingsRecord];
  @override
  final String wireName = 'RatingsRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, RatingsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.star;
    if (value != null) {
      result
        ..add('star')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.comment;
    if (value != null) {
      result
        ..add('comment')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.user;
    if (value != null) {
      result
        ..add('user')
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
  RatingsRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RatingsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'star':
          result.star = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'comment':
          result.comment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'user':
          result.user = serializers.deserialize(value,
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

class _$RatingsRecord extends RatingsRecord {
  @override
  final int? star;
  @override
  final String? comment;
  @override
  final DocumentReference<Object?>? user;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$RatingsRecord([void Function(RatingsRecordBuilder)? updates]) =>
      (new RatingsRecordBuilder()..update(updates))._build();

  _$RatingsRecord._({this.star, this.comment, this.user, this.ffRef})
      : super._();

  @override
  RatingsRecord rebuild(void Function(RatingsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RatingsRecordBuilder toBuilder() => new RatingsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RatingsRecord &&
        star == other.star &&
        comment == other.comment &&
        user == other.user &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, star.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, ffRef.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RatingsRecord')
          ..add('star', star)
          ..add('comment', comment)
          ..add('user', user)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class RatingsRecordBuilder
    implements Builder<RatingsRecord, RatingsRecordBuilder> {
  _$RatingsRecord? _$v;

  int? _star;
  int? get star => _$this._star;
  set star(int? star) => _$this._star = star;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  DocumentReference<Object?>? _user;
  DocumentReference<Object?>? get user => _$this._user;
  set user(DocumentReference<Object?>? user) => _$this._user = user;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  RatingsRecordBuilder() {
    RatingsRecord._initializeBuilder(this);
  }

  RatingsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _star = $v.star;
      _comment = $v.comment;
      _user = $v.user;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RatingsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RatingsRecord;
  }

  @override
  void update(void Function(RatingsRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RatingsRecord build() => _build();

  _$RatingsRecord _build() {
    final _$result = _$v ??
        new _$RatingsRecord._(
            star: star, comment: comment, user: user, ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
