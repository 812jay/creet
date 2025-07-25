import 'package:creet/lib/data/datasources/user_dto.dart';
import 'package:creet/lib/domain/entities/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// User 데이터 변환을 담당하는 Mapper 클래스
class UserMapper {
  /// Supabase User를 UserEntity로 변환
  static UserEntity? fromAuth(User? user) {
    if (user == null) return null;

    return UserDto(
      userId: user.id,
      email: user.email ?? '',
      displayName:
          user.userMetadata?['full_name'] ?? user.userMetadata?['name'],
      profileUrl: user.userMetadata?['avatar_url'],
    ).toEntity();
  }
}
