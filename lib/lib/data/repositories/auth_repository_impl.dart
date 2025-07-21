import 'dart:async';

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
      // Google Sign-In 초기화
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      unawaited(
        googleSignIn.initialize(
          serverClientId: dotenv.env['GOOGLE_WEB_CLIENT_ID'] ?? '',
        ),
      );
      // Google Sign-In 실행
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      // idToken 획득
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        throw Exception('Failed to get idToken from Google');
      }

      // Supabase에 idToken으로 로그인
      final AuthResponse response = await _supabaseClient.auth
          .signInWithIdToken(provider: OAuthProvider.google, idToken: idToken);
      
      return UserMapper.fromAuth(response.user);
    } catch (e) {
      throw Exception('Google sign in failed: $e');
    }
  }

  @override
  Future<UserEntity?> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final String idToken = credential.identityToken ?? '';

      if (idToken == '') {
        return null; // 취소는 에러가 아닌 정상적인 상황
      }

      // Supabase에 idToken으로 로그인
      final AuthResponse response = await _supabaseClient.auth
          .signInWithIdToken(provider: OAuthProvider.apple, idToken: idToken);

      return UserMapper.fromAuth(response.user);
    } catch (e) {
      // Apple 로그인 취소의 경우
      if (e.toString().contains('CANCELLED') ||
          e.toString().contains('NOT_INTERACTIVE')) {
        return null; // 취소는 에러가 아닌 정상적인 상황
      }
      throw Exception('Apple sign in failed: $e');
    }
  }

  @override
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final User? user = _supabaseClient.auth.currentUser;
    if (user != null) {
      final userDto = UserDto(
        userId: user.id,
        email: user.email ?? '',
        displayName:
            user.userMetadata?['full_name'] ?? user.userMetadata?['name'],
        profileUrl: user.userMetadata?['avatar_url'],
      );
      return userDto.toEntity();
    }
    return null;
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return _supabaseClient.auth.onAuthStateChange.map((AuthState data) {
      final user = data.session?.user;
      if (user != null) {
        final userDto = UserDto(
          userId: user.id,
          email: user.email ?? '',
          displayName:
              user.userMetadata?['full_name'] ?? user.userMetadata?['name'],
          profileUrl: user.userMetadata?['avatar_url'],
        );
        return userDto.toEntity();
      }
      return null;
    });
  }
}
