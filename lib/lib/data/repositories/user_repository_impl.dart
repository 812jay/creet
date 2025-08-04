import 'dart:developer' as developer;

import 'package:creet/lib/core/service/image_service.dart';
import 'package:creet/lib/core/utils/exceptions/async_wrapper.dart';
import 'package:creet/lib/data/datasources/user/user_entity.dart';
import 'package:creet/lib/domain/dto/auth/auth_credential_dto.dart';
import 'package:creet/lib/domain/dto/user/user_dto.dart';
import 'package:creet/lib/domain/repositories/user_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepositoryImpl implements UserRepository {
  final SupabaseClient _supabaseClient;
  final ImageService _imageService;

  UserRepositoryImpl(this._supabaseClient) : _imageService = ImageService();

  @override
  Future<void> signUp(AuthCredentialDto credential) async {
    await AsyncWrapper.wrap(
      () async {
        String? avatarFileName;

        // 프로필 이미지가 있으면 처리
        if (credential.photoURL != null) {
          // 1. photoUrl을 File로 변환
          final imageFile = await _imageService.convertUrlToFile(
            credential.photoURL!,
          );

          if (imageFile != null) {
            // 2. Supabase Storage에 업로드하고 파일명 받기
            avatarFileName = await _imageService.uploadImageToStorage(
              imageFile,
              credential.providerId,
            );

            // 3. 임시 파일 삭제
            await imageFile.delete();
          }
        }

        // 3. 사용자 정보 저장 (avatar_url에 파일명 저장)
        final response = await _supabaseClient.from('users').insert({
          'email': credential.email,
          'provider': credential.provider,
          'provider_id': credential.providerId,
          'nickname': credential.displayName,
          'avatar_url': avatarFileName,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });

        print('signUp: $response');
      },
      operationName: 'User Sign Up',
      errorMessage: '회원가입에 실패했습니다',
      shouldRethrow: true,
    );
  }

  @override
  Future<UserDto?> getCurrentUser() async {
    final String? providerId = _supabaseClient.auth.currentUser?.id;
    if (providerId != null) {
      developer.log(
        '현재 사용자 확인: $providerId',
        name: 'AuthRepository[getCurrentUser]',
      );

      return AsyncWrapper.wrap(
        () async {
          final userData =
              await _supabaseClient
                  .from('users')
                  .select()
                  .eq('provider_id', providerId)
                  .maybeSingle();
          if (userData != null) {
            return UserEntity.fromJson(userData).toDto();
          }
          throw Exception('사용자 데이터를 찾을 수 없습니다');
        },
        operationName: 'Get Current User',
        errorMessage: '사용자 데이터 조회에 실패했습니다',
      );
    }
    developer.log('현재 사용자 없음', name: 'AuthRepository[getCurrentUser]');
    return null;
  }
}
