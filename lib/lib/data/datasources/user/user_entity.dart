import 'package:creet/lib/domain/dto/user/user_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'provider') required String provider,
    @JsonKey(name: 'provider_id') required String providerId,
    @JsonKey(name: 'nickname') String? nickname,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}

extension UserEntityExtensions on UserEntity {
  UserDto toDto() => UserDto(
    id: id,
    email: email,
    provider: provider,
    providerId: providerId,
    nickname: nickname,
    avatarUrl: avatarUrl,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  /// UserEntity를 간단한 UserDto로 변환 (필수 필드만)
  UserDto toSimpleDto() =>
      UserDto(id: id, email: email, provider: provider, providerId: providerId);

  /// 사용자 표시명 반환 (nickname이 있으면 nickname, 없으면 email)
  String get displayName => nickname ?? email;

  /// 프로필 이미지가 있는지 확인
  bool get hasAvatar => avatarUrl != null && avatarUrl!.isNotEmpty;

  /// 새 사용자인지 확인 (createdAt이 오늘인지)
  bool get isNewUser {
    if (createdAt == null) return false;
    final now = DateTime.now();
    final created = createdAt!;
    return created.year == now.year &&
        created.month == now.month &&
        created.day == now.day;
  }
}
