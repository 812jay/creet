// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CategoryDto _$CategoryDtoFromJson(Map<String, dynamic> json) {
  return _CategoryDto.fromJson(json);
}

/// @nodoc
mixin _$CategoryDto {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get templateId => throw _privateConstructorUsedError;
  String? get customIconUrl => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isFixed => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this CategoryDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CategoryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryDtoCopyWith<CategoryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryDtoCopyWith<$Res> {
  factory $CategoryDtoCopyWith(
    CategoryDto value,
    $Res Function(CategoryDto) then,
  ) = _$CategoryDtoCopyWithImpl<$Res, CategoryDto>;
  @useResult
  $Res call({
    String id,
    String name,
    String userId,
    String templateId,
    String? customIconUrl,
    String type,
    bool isActive,
    bool isFixed,
    int sortOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$CategoryDtoCopyWithImpl<$Res, $Val extends CategoryDto>
    implements $CategoryDtoCopyWith<$Res> {
  _$CategoryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? userId = null,
    Object? templateId = null,
    Object? customIconUrl = freezed,
    Object? type = null,
    Object? isActive = null,
    Object? isFixed = null,
    Object? sortOrder = null,
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
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            userId:
                null == userId
                    ? _value.userId
                    : userId // ignore: cast_nullable_to_non_nullable
                        as String,
            templateId:
                null == templateId
                    ? _value.templateId
                    : templateId // ignore: cast_nullable_to_non_nullable
                        as String,
            customIconUrl:
                freezed == customIconUrl
                    ? _value.customIconUrl
                    : customIconUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String,
            isActive:
                null == isActive
                    ? _value.isActive
                    : isActive // ignore: cast_nullable_to_non_nullable
                        as bool,
            isFixed:
                null == isFixed
                    ? _value.isFixed
                    : isFixed // ignore: cast_nullable_to_non_nullable
                        as bool,
            sortOrder:
                null == sortOrder
                    ? _value.sortOrder
                    : sortOrder // ignore: cast_nullable_to_non_nullable
                        as int,
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
abstract class _$$CategoryDtoImplCopyWith<$Res>
    implements $CategoryDtoCopyWith<$Res> {
  factory _$$CategoryDtoImplCopyWith(
    _$CategoryDtoImpl value,
    $Res Function(_$CategoryDtoImpl) then,
  ) = __$$CategoryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String userId,
    String templateId,
    String? customIconUrl,
    String type,
    bool isActive,
    bool isFixed,
    int sortOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$CategoryDtoImplCopyWithImpl<$Res>
    extends _$CategoryDtoCopyWithImpl<$Res, _$CategoryDtoImpl>
    implements _$$CategoryDtoImplCopyWith<$Res> {
  __$$CategoryDtoImplCopyWithImpl(
    _$CategoryDtoImpl _value,
    $Res Function(_$CategoryDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? userId = null,
    Object? templateId = null,
    Object? customIconUrl = freezed,
    Object? type = null,
    Object? isActive = null,
    Object? isFixed = null,
    Object? sortOrder = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$CategoryDtoImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        userId:
            null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                    as String,
        templateId:
            null == templateId
                ? _value.templateId
                : templateId // ignore: cast_nullable_to_non_nullable
                    as String,
        customIconUrl:
            freezed == customIconUrl
                ? _value.customIconUrl
                : customIconUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
        isActive:
            null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                    as bool,
        isFixed:
            null == isFixed
                ? _value.isFixed
                : isFixed // ignore: cast_nullable_to_non_nullable
                    as bool,
        sortOrder:
            null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                    as int,
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
class _$CategoryDtoImpl implements _CategoryDto {
  const _$CategoryDtoImpl({
    required this.id,
    required this.name,
    required this.userId,
    required this.templateId,
    this.customIconUrl,
    required this.type,
    required this.isActive,
    required this.isFixed,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory _$CategoryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String userId;
  @override
  final String templateId;
  @override
  final String? customIconUrl;
  @override
  final String type;
  @override
  final bool isActive;
  @override
  final bool isFixed;
  @override
  final int sortOrder;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'CategoryDto(id: $id, name: $name, userId: $userId, templateId: $templateId, customIconUrl: $customIconUrl, type: $type, isActive: $isActive, isFixed: $isFixed, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            (identical(other.customIconUrl, customIconUrl) ||
                other.customIconUrl == customIconUrl) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isFixed, isFixed) || other.isFixed == isFixed) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
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
    name,
    userId,
    templateId,
    customIconUrl,
    type,
    isActive,
    isFixed,
    sortOrder,
    createdAt,
    updatedAt,
  );

  /// Create a copy of CategoryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryDtoImplCopyWith<_$CategoryDtoImpl> get copyWith =>
      __$$CategoryDtoImplCopyWithImpl<_$CategoryDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryDtoImplToJson(this);
  }
}

abstract class _CategoryDto implements CategoryDto {
  const factory _CategoryDto({
    required final String id,
    required final String name,
    required final String userId,
    required final String templateId,
    final String? customIconUrl,
    required final String type,
    required final bool isActive,
    required final bool isFixed,
    required final int sortOrder,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$CategoryDtoImpl;

  factory _CategoryDto.fromJson(Map<String, dynamic> json) =
      _$CategoryDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get userId;
  @override
  String get templateId;
  @override
  String? get customIconUrl;
  @override
  String get type;
  @override
  bool get isActive;
  @override
  bool get isFixed;
  @override
  int get sortOrder;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of CategoryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryDtoImplCopyWith<_$CategoryDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
