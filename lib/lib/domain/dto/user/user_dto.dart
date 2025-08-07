import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required String id,
    required String email,
    required String provider,
    String? nickname,
    String? avatarUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserDto;

  const UserDto._(); // 커스텀 메서드용

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
    id: json['id'] as String,
    email: json['email'] as String,
    provider: json['provider'] as String,
    nickname: json['nickname'] as String?,
    avatarUrl: json['avatar_url'] as String?,
    createdAt:
        json['created_at'] != null
            ? DateTime.parse(json['created_at'] as String)
            : null,
    updatedAt:
        json['updated_at'] != null
            ? DateTime.parse(json['updated_at'] as String)
            : null,
  );

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
