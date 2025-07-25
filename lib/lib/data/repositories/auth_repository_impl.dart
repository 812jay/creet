import 'dart:async';
import 'dart:developer' as developer;

import 'package:creet/lib/core/mappers/user_mapper.dart';
import 'package:creet/lib/data/datasources/user_dto.dart';
import 'package:creet/lib/domain/entities/user_entity.dart';
import 'package:creet/lib/domain/repositories/auth_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _supabaseClient;

  AuthRepositoryImpl(this._supabaseClient);

  @override
  Future<UserEntity?> signInWithGoogle() async {
    try {
      developer.log('Google Sign-In 시작', name: 'AuthRepository');

      // Google Sign-In 초기화
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      unawaited(
        googleSignIn.initialize(
          serverClientId: dotenv.env['GOOGLE_WEB_CLIENT_ID'] ?? '',
        ),
      );

      developer.log('Google Sign-In 인증 시도', name: 'AuthRepository');
      // Google Sign-In 실행
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      // idToken 획득
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        developer.log('Google idToken 획득 실패', name: 'AuthRepository');
        throw Exception('Failed to get idToken from Google');
      }

      developer.log(
        'Google idToken 획득 성공, Supabase 로그인 시도',
        name: 'AuthRepository',
      );
      // Supabase에 idToken으로 로그인
      final AuthResponse response = await _supabaseClient.auth
          .signInWithIdToken(provider: OAuthProvider.google, idToken: idToken);

      developer.log(
        'Supabase 로그인 성공: ${response.user?.email}',
        name: 'AuthRepository',
      );
      return UserMapper.fromAuth(response.user);
    } catch (e) {
      developer.log('Google Sign-In 실패: $e', name: 'AuthRepository');
      throw Exception('Google sign in failed: $e');
    }
  }

  @override
  Future<UserEntity?> signInWithApple() async {
    try {
      developer.log('Apple Sign-In 시작', name: 'AuthRepository');

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final String idToken = credential.identityToken ?? '';

      if (idToken == '') {
        developer.log('Apple Sign-In 취소됨', name: 'AuthRepository');
        return null; // 취소는 에러가 아닌 정상적인 상황
      }

      developer.log(
        'Apple idToken 획득 성공, Supabase 로그인 시도',
        name: 'AuthRepository',
      );
      // Supabase에 idToken으로 로그인
      final AuthResponse response = await _supabaseClient.auth
          .signInWithIdToken(provider: OAuthProvider.apple, idToken: idToken);

      developer.log(
        'Supabase Apple 로그인 성공: ${response.user?.email}',
        name: 'AuthRepository',
      );
      return UserMapper.fromAuth(response.user);
    } catch (e) {
      // Apple 로그인 취소의 경우
      if (e.toString().contains('CANCELLED') ||
          e.toString().contains('NOT_INTERACTIVE')) {
        developer.log('Apple Sign-In 취소됨', name: 'AuthRepository');
        return null; // 취소는 에러가 아닌 정상적인 상황
      }
      developer.log('Apple Sign-In 실패: $e', name: 'AuthRepository');
      throw Exception('Apple sign in failed: $e');
    }
  }

  @override
  Future<void> signOut() async {
    developer.log('로그아웃 시작', name: 'AuthRepository');
    await _supabaseClient.auth.signOut();
    developer.log('로그아웃 완료', name: 'AuthRepository');
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final User? user = _supabaseClient.auth.currentUser;
    if (user != null) {
      developer.log('현재 사용자 확인: ${user.email}', name: 'AuthRepository');
      final userDto = UserDto(
        userId: user.id,
        email: user.email ?? '',
        displayName:
            user.userMetadata?['full_name'] ?? user.userMetadata?['name'],
        profileUrl: user.userMetadata?['avatar_url'],
      );
      return userDto.toEntity();
    }
    developer.log('현재 사용자 없음', name: 'AuthRepository');
    return null;
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return _supabaseClient.auth.onAuthStateChange.map((AuthState data) {
      final user = data.session?.user;
      if (user != null) {
        developer.log('인증 상태 변경: 로그인됨 - ${user.email}', name: 'AuthRepository');
        final userDto = UserDto(
          userId: user.id,
          email: user.email ?? '',
          displayName:
              user.userMetadata?['full_name'] ?? user.userMetadata?['name'],
          profileUrl: user.userMetadata?['avatar_url'],
        );
        return userDto.toEntity();
      }
      developer.log('인증 상태 변경: 로그아웃됨', name: 'AuthRepository');
      return null;
    });
  }
}
