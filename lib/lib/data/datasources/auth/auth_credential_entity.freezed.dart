// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_credential_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AuthCredentialEntity _$AuthCredentialEntityFromJson(Map<String, dynamic> json) {
  return _AuthCredentialEntity.fromJson(json);
}

/// @nodoc
mixin _$AuthCredentialEntity {
  @JsonKey(name: 'id_token')
  String get idToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'provider')
  String get provider => throw _privateConstructorUsedError;
  @JsonKey(name: 'provider_id')
  String get providerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'email')
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_name')
  String? get displayName => throw _privateConstructorUsedError;
  @JsonKey(name: 'photo_url')
  String? get photoURL => throw _privateConstructorUsedError;

  /// Serializes this AuthCredentialEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthCredentialEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthCredentialEntityCopyWith<AuthCredentialEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthCredentialEntityCopyWith<$Res> {
  factory $AuthCredentialEntityCopyWith(
    AuthCredentialEntity value,
    $Res Function(AuthCredentialEntity) then,
  ) = _$AuthCredentialEntityCopyWithImpl<$Res, AuthCredentialEntity>;
  @useResult
  $Res call({
    @JsonKey(name: 'id_token') String idToken,
    @JsonKey(name: 'provider') String provider,
    @JsonKey(name: 'provider_id') String providerId,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'photo_url') String? photoURL,
  });
}

/// @nodoc
class _$AuthCredentialEntityCopyWithImpl<
  $Res,
  $Val extends AuthCredentialEntity
>
    implements $AuthCredentialEntityCopyWith<$Res> {
  _$AuthCredentialEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthCredentialEntity
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
abstract class _$$AuthCredentialEntityImplCopyWith<$Res>
    implements $AuthCredentialEntityCopyWith<$Res> {
  factory _$$AuthCredentialEntityImplCopyWith(
    _$AuthCredentialEntityImpl value,
    $Res Function(_$AuthCredentialEntityImpl) then,
  ) = __$$AuthCredentialEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id_token') String idToken,
    @JsonKey(name: 'provider') String provider,
    @JsonKey(name: 'provider_id') String providerId,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'photo_url') String? photoURL,
  });
}

/// @nodoc
class __$$AuthCredentialEntityImplCopyWithImpl<$Res>
    extends _$AuthCredentialEntityCopyWithImpl<$Res, _$AuthCredentialEntityImpl>
    implements _$$AuthCredentialEntityImplCopyWith<$Res> {
  __$$AuthCredentialEntityImplCopyWithImpl(
    _$AuthCredentialEntityImpl _value,
    $Res Function(_$AuthCredentialEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthCredentialEntity
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
      _$AuthCredentialEntityImpl(
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
class _$AuthCredentialEntityImpl implements _AuthCredentialEntity {
  const _$AuthCredentialEntityImpl({
    @JsonKey(name: 'id_token') required this.idToken,
    @JsonKey(name: 'provider') required this.provider,
    @JsonKey(name: 'provider_id') required this.providerId,
    @JsonKey(name: 'email') this.email,
    @JsonKey(name: 'display_name') this.displayName,
    @JsonKey(name: 'photo_url') this.photoURL,
  });

  factory _$AuthCredentialEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthCredentialEntityImplFromJson(json);

  @override
  @JsonKey(name: 'id_token')
  final String idToken;
  @override
  @JsonKey(name: 'provider')
  final String provider;
  @override
  @JsonKey(name: 'provider_id')
  final String providerId;
  @override
  @JsonKey(name: 'email')
  final String? email;
  @override
  @JsonKey(name: 'display_name')
  final String? displayName;
  @override
  @JsonKey(name: 'photo_url')
  final String? photoURL;

  @override
  String toString() {
    return 'AuthCredentialEntity(idToken: $idToken, provider: $provider, providerId: $providerId, email: $email, displayName: $displayName, photoURL: $photoURL)';
  }

  AuthCredentialDto toDto() => AuthCredentialDto(
    idToken: idToken,
    provider: provider,
    providerId: providerId,
    email: email,
    displayName: displayName,
    photoURL: photoURL,
  );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthCredentialEntityImpl &&
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

  /// Create a copy of AuthCredentialEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthCredentialEntityImplCopyWith<_$AuthCredentialEntityImpl>
  get copyWith =>
      __$$AuthCredentialEntityImplCopyWithImpl<_$AuthCredentialEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthCredentialEntityImplToJson(this);
  }
}

abstract class _AuthCredentialEntity implements AuthCredentialEntity {
  const factory _AuthCredentialEntity({
    @JsonKey(name: 'id_token') required final String idToken,
    @JsonKey(name: 'provider') required final String provider,
    @JsonKey(name: 'provider_id') required final String providerId,
    @JsonKey(name: 'email') final String? email,
    @JsonKey(name: 'display_name') final String? displayName,
    @JsonKey(name: 'photo_url') final String? photoURL,
  }) = _$AuthCredentialEntityImpl;

  factory _AuthCredentialEntity.fromJson(Map<String, dynamic> json) =
      _$AuthCredentialEntityImpl.fromJson;

  @override
  @JsonKey(name: 'id_token')
  String get idToken;
  @override
  @JsonKey(name: 'provider')
  String get provider;
  @override
  @JsonKey(name: 'provider_id')
  String get providerId;
  @override
  @JsonKey(name: 'email')
  String? get email;
  @override
  @JsonKey(name: 'display_name')
  String? get displayName;
  @override
  @JsonKey(name: 'photo_url')
  String? get photoURL;

  /// Create a copy of AuthCredentialEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthCredentialEntityImplCopyWith<_$AuthCredentialEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
