import 'dart:io';

import 'package:creet/lib/core/service/image_service.dart';
import 'package:creet/lib/core/utils/exceptions/async_wrapper.dart';
import 'package:creet/lib/core/utils/logger.dart';
import 'package:creet/lib/domain/dto/user/user_dto.dart';
import 'package:creet/lib/domain/dto/auth/auth_credential_dto.dart';
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
        String? avatarPath;

        // 프로필 이미지가 있으면 처리
        if (credential.photoURL != null) {
          Logger.info(
            '프로필 이미지 처리 시작: ${credential.photoURL}',
            tag: 'UserRepository',
          );

          // 1. photoUrl을 File로 변환
          final File? imageFile = await _imageService.convertUrlToFile(
            credential.photoURL!,
          );

          if (imageFile != null) {
            Logger.info(
              '이미지 파일 변환 성공: ${imageFile.path}',
              tag: 'UserRepository',
            );

            // 2. Supabase Storage에 업로드하고 파일명 받기
            avatarPath = await _imageService.uploadImageToStorage(
              bucketName: 'avatars',
              imagePath: credential.providerId,
              image: imageFile,
            );

            if (avatarPath != null) {
              Logger.info('이미지 업로드 성공, 경로: $avatarPath', tag: 'UserRepository');
            } else {
              Logger.error('이미지 업로드 실패', tag: 'UserRepository');
            }

            // 3. 임시 파일 삭제
            await imageFile.delete();
            Logger.info('임시 파일 삭제 완료', tag: 'UserRepository');
          } else {
            Logger.error('이미지 파일 변환 실패', tag: 'UserRepository');
          }
        } else {
          Logger.info('프로필 이미지가 없습니다', tag: 'UserRepository');
        }

        // 3. 사용자 정보 저장 (avatar_url에 파일명 저장)
        final response = await _supabaseClient.from('users').insert({
          'id': credential.providerId, // Supabase Auth의 ID와 동일하게 설정
          'email': credential.email,
          'provider': credential.provider,
          'nickname': credential.displayName,
          'avatar_url': avatarPath,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });

        Logger.info('signUp: $response', tag: 'UserRepository');
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
      Logger.info('현재 사용자 확인: $providerId', tag: 'UserRepository');

      return AsyncWrapper.wrap(
        () async {
          Logger.info('검색할 provider_id: "$providerId"', tag: 'UserRepository');

          // provider_id 대신 다른 컬럼명 시도
          final userData =
              await _supabaseClient
                  .from('users')
                  .select()
                  .eq('id', providerId)
                  .maybeSingle();
          if (userData != null) {
            return UserDto.fromJson(userData);
          }
          throw Exception('사용자 데이터를 찾을 수 없습니다');
        },
        operationName: 'Get Current User',
        errorMessage: '사용자 데이터 조회에 실패했습니다',
      );
    }
    Logger.info('현재 사용자 없음', tag: 'UserRepository');
    return null;
  }

  // @override
  // Future<void> uploadAvatar(String userId, File image) async {
  //   await AsyncWrapper.wrap(() async {
  //     await _imageService.uploadImageToStorage(
  //       bucketName: 'avatars',
  //       imagePath: userId,
  //       image: image,
  //     );
  //   });
  // }
}
