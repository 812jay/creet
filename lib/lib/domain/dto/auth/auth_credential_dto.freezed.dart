// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_credential_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AuthCredentialDto _$AuthCredentialDtoFromJson(Map<String, dynamic> json) {
  return _AuthCredentialDto.fromJson(json);
}

/// @nodoc
mixin _$AuthCredentialDto {
  String get idToken => throw _privateConstructorUsedError;
  String get provider => throw _privateConstructorUsedError;
  String get providerId => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get photoURL => throw _privateConstructorUsedError;

  /// Serializes this AuthCredentialDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthCredentialDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthCredentialDtoCopyWith<AuthCredentialDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthCredentialDtoCopyWith<$Res> {
  factory $AuthCredentialDtoCopyWith(
    AuthCredentialDto value,
    $Res Function(AuthCredentialDto) then,
  ) = _$AuthCredentialDtoCopyWithImpl<$Res, AuthCredentialDto>;
  @useResult
  $Res call({
    String idToken,
    String provider,
    String providerId,
    String? email,
    String? displayName,
    String? photoURL,
  });
}

/// @nodoc
class _$AuthCredentialDtoCopyWithImpl<$Res, $Val extends AuthCredentialDto>
    implements $AuthCredentialDtoCopyWith<$Res> {
  _$AuthCredentialDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthCredentialDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idToken = null,
    Object? provider = null,
    Object? providerId = null,
    Object? email = freezed,
    Object? displayName = freezed,
    Object? photoURL = freezed,
  }) {
    return _then(
      _value.copyWith(
            idToken:
                null == idToken
                    ? _value.idToken
                    : idToken // ignore: cast_nullable_to_non_nullable
                        as String,
            provider:
                null == provider
                    ? _value.provider
                    : provider // ignore: cast_nullable_to_non_nullable
                        as String,
            providerId:
                null == providerId
                    ? _value.providerId
                    : providerId // ignore: cast_nullable_to_non_nullable
                        as String,
            email:
                freezed == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String?,
            displayName:
                freezed == displayName
                    ? _value.displayName
                    : displayName // ignore: cast_nullable_to_non_nullable
                        as String?,
            photoURL:
                freezed == photoURL
                    ? _value.photoURL
                    : photoURL // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthCredentialDtoImplCopyWith<$Res>
    implements $AuthCredentialDtoCopyWith<$Res> {
  factory _$$AuthCredentialDtoImplCopyWith(
    _$AuthCredentialDtoImpl value,
    $Res Function(_$AuthCredentialDtoImpl) then,
  ) = __$$AuthCredentialDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String idToken,
    String provider,
    String providerId,
    String? email,
    String? displayName,
    String? photoURL,
  });
}

/// @nodoc
class __$$AuthCredentialDtoImplCopyWithImpl<$Res>
    extends _$AuthCredentialDtoCopyWithImpl<$Res, _$AuthCredentialDtoImpl>
    implements _$$AuthCredentialDtoImplCopyWith<$Res> {
  __$$AuthCredentialDtoImplCopyWithImpl(
    _$AuthCredentialDtoImpl _value,
    $Res Function(_$AuthCredentialDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthCredentialDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idToken = null,
    Object? provider = null,
    Object? providerId = null,
    Object? email = freezed,
    Object? displayName = freezed,
    Object? photoURL = freezed,
  }) {
    return _then(
      _$AuthCredentialDtoImpl(
        idToken:
            null == idToken
                ? _value.idToken
                : idToken // ignore: cast_nullable_to_non_nullable
                    as String,
        provider:
            null == provider
                ? _value.provider
                : provider // ignore: cast_nullable_to_non_nullable
                    as String,
        providerId:
            null == providerId
                ? _value.providerId
                : providerId // ignore: cast_nullable_to_non_nullable
                    as String,
        email:
            freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String?,
        displayName:
            freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                    as String?,
        photoURL:
            freezed == photoURL
                ? _value.photoURL
                : photoURL // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthCredentialDtoImpl implements _AuthCredentialDto {
  const _$AuthCredentialDtoImpl({
    required this.idToken,
    required this.provider,
    required this.providerId,
    this.email,
    this.displayName,
    this.photoURL,
  });

  factory _$AuthCredentialDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthCredentialDtoImplFromJson(json);

  @override
  final String idToken;
  @override
  final String provider;
  @override
  final String providerId;
  @override
  final String? email;
  @override
  final String? displayName;
  @override
  final String? photoURL;

  @override
  String toString() {
    return 'AuthCredentialDto(idToken: $idToken, provider: $provider, providerId: $providerId, email: $email, displayName: $displayName, photoURL: $photoURL)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthCredentialDtoImpl &&
            (identical(other.idToken, idToken) || other.idToken == idToken) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoURL, photoURL) ||
                other.photoURL == photoURL));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    idToken,
    provider,
    providerId,
    email,
    displayName,
    photoURL,
  );

  /// Create a copy of AuthCredentialDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthCredentialDtoImplCopyWith<_$AuthCredentialDtoImpl> get copyWith =>
      __$$AuthCredentialDtoImplCopyWithImpl<_$AuthCredentialDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthCredentialDtoImplToJson(this);
  }
}

abstract class _AuthCredentialDto implements AuthCredentialDto {
  const factory _AuthCredentialDto({
    required final String idToken,
    required final String provider,
    required final String providerId,
    final String? email,
    final String? displayName,
    final String? photoURL,
  }) = _$AuthCredentialDtoImpl;

  factory _AuthCredentialDto.fromJson(Map<String, dynamic> json) =
      _$AuthCredentialDtoImpl.fromJson;

  @override
  String get idToken;
  @override
  String get provider;
  @override
  String get providerId;
  @override
  String? get email;
  @override
  String? get displayName;
  @override
  String? get photoURL;

  /// Create a copy of AuthCredentialDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthCredentialDtoImplCopyWith<_$AuthCredentialDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
