// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utils_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UtilsRecord> _$utilsRecordSerializer = new _$UtilsRecordSerializer();

class _$UtilsRecordSerializer implements StructuredSerializer<UtilsRecord> {
  @override
  final Iterable<Type> types = const [UtilsRecord, _$UtilsRecord];
  @override
  final String wireName = 'UtilsRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, UtilsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.joblist;
    if (value != null) {
      result
        ..add('joblist')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
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
  UtilsRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UtilsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'joblist':
          result.joblist.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
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

class _$UtilsRecord extends UtilsRecord {
  @override
  final BuiltList<String>? joblist;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$UtilsRecord([void Function(UtilsRecordBuilder)? updates]) =>
      (new UtilsRecordBuilder()..update(updates))._build();

  _$UtilsRecord._({this.joblist, this.ffRef}) : super._();

  @override
  UtilsRecord rebuild(void Function(UtilsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UtilsRecordBuilder toBuilder() => new UtilsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UtilsRecord &&
        joblist == other.joblist &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, joblist.hashCode), ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UtilsRecord')
          ..add('joblist', joblist)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class UtilsRecordBuilder implements Builder<UtilsRecord, UtilsRecordBuilder> {
  _$UtilsRecord? _$v;

  ListBuilder<String>? _joblist;
  ListBuilder<String> get joblist =>
      _$this._joblist ??= new ListBuilder<String>();
  set joblist(ListBuilder<String>? joblist) => _$this._joblist = joblist;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  UtilsRecordBuilder() {
    UtilsRecord._initializeBuilder(this);
  }

  UtilsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _joblist = $v.joblist?.toBuilder();
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UtilsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UtilsRecord;
  }

  @override
  void update(void Function(UtilsRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UtilsRecord build() => _build();

  _$UtilsRecord _build() {
    _$UtilsRecord _$result;
    try {
      _$result =
          _$v ?? new _$UtilsRecord._(joblist: _joblist?.build(), ffRef: ffRef);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'joblist';
        _joblist?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'UtilsRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
