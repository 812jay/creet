// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'income_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

IncomeDto _$IncomeDtoFromJson(Map<String, dynamic> json) {
  return _IncomeDto.fromJson(json);
}

/// @nodoc
mixin _$IncomeDto {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this IncomeDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IncomeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IncomeDtoCopyWith<IncomeDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncomeDtoCopyWith<$Res> {
  factory $IncomeDtoCopyWith(IncomeDto value, $Res Function(IncomeDto) then) =
      _$IncomeDtoCopyWithImpl<$Res, IncomeDto>;
  @useResult
  $Res call({
    String id,
    String userId,
    String categoryId,
    String amount,
    String date,
    String? description,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$IncomeDtoCopyWithImpl<$Res, $Val extends IncomeDto>
    implements $IncomeDtoCopyWith<$Res> {
  _$IncomeDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IncomeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? categoryId = null,
    Object? amount = null,
    Object? date = null,
    Object? description = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            userId:
                null == userId
                    ? _value.userId
                    : userId // ignore: cast_nullable_to_non_nullable
                        as String,
            categoryId:
                null == categoryId
                    ? _value.categoryId
                    : categoryId // ignore: cast_nullable_to_non_nullable
                        as String,
            amount:
                null == amount
                    ? _value.amount
                    : amount // ignore: cast_nullable_to_non_nullable
                        as String,
            date:
                null == date
                    ? _value.date
                    : date // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                freezed == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String?,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            updatedAt:
                null == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IncomeDtoImplCopyWith<$Res>
    implements $IncomeDtoCopyWith<$Res> {
  factory _$$IncomeDtoImplCopyWith(
    _$IncomeDtoImpl value,
    $Res Function(_$IncomeDtoImpl) then,
  ) = __$$IncomeDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String categoryId,
    String amount,
    String date,
    String? description,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$IncomeDtoImplCopyWithImpl<$Res>
    extends _$IncomeDtoCopyWithImpl<$Res, _$IncomeDtoImpl>
    implements _$$IncomeDtoImplCopyWith<$Res> {
  __$$IncomeDtoImplCopyWithImpl(
    _$IncomeDtoImpl _value,
    $Res Function(_$IncomeDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IncomeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? categoryId = null,
    Object? amount = null,
    Object? date = null,
    Object? description = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$IncomeDtoImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        userId:
            null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                    as String,
        categoryId:
            null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                    as String,
        amount:
            null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as String,
        date:
            null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String?,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        updatedAt:
            null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IncomeDtoImpl implements _IncomeDto {
  const _$IncomeDtoImpl({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.amount,
    required this.date,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory _$IncomeDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$IncomeDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String categoryId;
  @override
  final String amount;
  @override
  final String date;
  @override
  final String? description;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'IncomeDto(id: $id, userId: $userId, categoryId: $categoryId, amount: $amount, date: $date, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncomeDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    categoryId,
    amount,
    date,
    description,
    createdAt,
    updatedAt,
  );

  /// Create a copy of IncomeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IncomeDtoImplCopyWith<_$IncomeDtoImpl> get copyWith =>
      __$$IncomeDtoImplCopyWithImpl<_$IncomeDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IncomeDtoImplToJson(this);
  }
}

abstract class _IncomeDto implements IncomeDto {
  const factory _IncomeDto({
    required final String id,
    required final String userId,
    required final String categoryId,
    required final String amount,
    required final String date,
    final String? description,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$IncomeDtoImpl;

  factory _IncomeDto.fromJson(Map<String, dynamic> json) =
      _$IncomeDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get categoryId;
  @override
  String get amount;
  @override
  String get date;
  @override
  String? get description;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of IncomeDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IncomeDtoImplCopyWith<_$IncomeDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
