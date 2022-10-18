// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interests_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<InterestsRecord> _$interestsRecordSerializer =
    new _$InterestsRecordSerializer();

class _$InterestsRecordSerializer
    implements StructuredSerializer<InterestsRecord> {
  @override
  final Iterable<Type> types = const [InterestsRecord, _$InterestsRecord];
  @override
  final String wireName = 'InterestsRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, InterestsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.photoUrl;
    if (value != null) {
      result
        ..add('photo_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.followers;
    if (value != null) {
      result
        ..add('followers')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
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
  InterestsRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InterestsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'photo_url':
          result.photoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'followers':
          result.followers.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
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

class _$InterestsRecord extends InterestsRecord {
  @override
  final String? name;
  @override
  final String? photoUrl;
  @override
  final BuiltList<DocumentReference<Object?>>? followers;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$InterestsRecord([void Function(InterestsRecordBuilder)? updates]) =>
      (new InterestsRecordBuilder()..update(updates))._build();

  _$InterestsRecord._({this.name, this.photoUrl, this.followers, this.ffRef})
      : super._();

  @override
  InterestsRecord rebuild(void Function(InterestsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InterestsRecordBuilder toBuilder() =>
      new InterestsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InterestsRecord &&
        name == other.name &&
        photoUrl == other.photoUrl &&
        followers == other.followers &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, name.hashCode), photoUrl.hashCode), followers.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InterestsRecord')
          ..add('name', name)
          ..add('photoUrl', photoUrl)
          ..add('followers', followers)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class InterestsRecordBuilder
    implements Builder<InterestsRecord, InterestsRecordBuilder> {
  _$InterestsRecord? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _photoUrl;
  String? get photoUrl => _$this._photoUrl;
  set photoUrl(String? photoUrl) => _$this._photoUrl = photoUrl;

  ListBuilder<DocumentReference<Object?>>? _followers;
  ListBuilder<DocumentReference<Object?>> get followers =>
      _$this._followers ??= new ListBuilder<DocumentReference<Object?>>();
  set followers(ListBuilder<DocumentReference<Object?>>? followers) =>
      _$this._followers = followers;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  InterestsRecordBuilder() {
    InterestsRecord._initializeBuilder(this);
  }

  InterestsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _photoUrl = $v.photoUrl;
      _followers = $v.followers?.toBuilder();
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InterestsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$InterestsRecord;
  }

  @override
  void update(void Function(InterestsRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InterestsRecord build() => _build();

  _$InterestsRecord _build() {
    _$InterestsRecord _$result;
    try {
      _$result = _$v ??
          new _$InterestsRecord._(
              name: name,
              photoUrl: photoUrl,
              followers: _followers?.build(),
              ffRef: ffRef);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'followers';
        _followers?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'InterestsRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
