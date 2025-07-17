import 'dart:async';

import 'package:creet/lib/core/mappers/user_mapper.dart';
import 'package:creet/lib/data/datasources/user_dto.dart';
import 'package:creet/lib/domain/entities/user_entity.dart';
import 'package:creet/lib/domain/repositories/auth_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
