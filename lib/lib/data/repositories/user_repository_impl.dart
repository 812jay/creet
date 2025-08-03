import 'dart:developer' as developer;
import 'dart:io';

import 'package:creet/lib/core/service/image_service.dart';
import 'package:creet/lib/domain/dto/auth/auth_credential_dto.dart';
import 'package:creet/lib/domain/repositories/user_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepositoryImpl implements UserRepository {
  final SupabaseClient _supabaseClient;
  final ImageService _imageService;

  UserRepositoryImpl(this._supabaseClient) : _imageService = ImageService();

  @override
  Future<void> signUp(AuthCredentialDto credential) async {
    try {
      developer.log(
        'signUp: ${credential.toJson()}',
        name: 'UserRepositoryImpl',
      );

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
        'avatar_url': avatarFileName, // 파일명 저장 (예: "user123/1703123456789.jpg")
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });

      print('signUp: $response');
    } catch (e) {
      print('signUp error: $e');
      rethrow;
    }
  }
}
