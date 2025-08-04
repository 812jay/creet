import 'dart:async';
import 'dart:developer' as developer;

import 'package:creet/lib/core/utils/exceptions/async_wrapper.dart';
import 'package:creet/lib/data/datasources/auth/auth_credential_entity.dart';
import 'package:creet/lib/data/datasources/user/user_entity.dart';
import 'package:creet/lib/domain/dto/auth/auth_credential_dto.dart';
import 'package:creet/lib/domain/dto/user/user_dto.dart';
import 'package:creet/lib/domain/repositories/auth_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _supabaseClient;

  AuthRepositoryImpl(this._supabaseClient);
  @override
  Future<AuthCredentialDto?> signinWithGoogle() async {
    return AsyncWrapper.wrap(
      () async {
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
        final GoogleSignInAccount googleUser =
            await googleSignIn.authenticate();

        // idToken 획득
        final GoogleSignInAuthentication googleAuth = googleUser.authentication;
        final String? idToken = googleAuth.idToken;

        if (idToken == null) {
          developer.log(
            'Google idToken 획득 실패',
            name: 'AuthRepository[authWithGoogle]',
          );
          throw Exception('Google idToken 획득 실패');
        }

        final response = await _supabaseClient.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: idToken,
        );
        final authUser = response.user!;

        final entity = AuthCredentialEntity(
          idToken: idToken,
          providerId: authUser.id,
          provider: OAuthProvider.google.name,
          email: authUser.email,
          displayName: authUser.userMetadata?['name'] ?? '',
          photoURL: authUser.userMetadata?['picture'] ?? '',
        );
        final dto = entity.toDto();
        return dto;
      },
      operationName: 'Google Sign-In',
      errorMessage: 'Google 로그인에 실패했습니다',
    );
  }

  @override
  Future<AuthCredentialDto?> signinWithApple() async {
    return AsyncWrapper.wrap(
      () async {
        developer.log(
          'Apple Sign-In 시작',
          name: 'AuthRepository[authWithApple]',
        );

        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        final String idToken = credential.identityToken ?? '';

        if (idToken == '') {
          developer.log(
            'Apple Sign-In 취소됨',
            name: 'AuthRepository[authWithApple]',
          );
          throw Exception('Apple Sign-In 취소됨');
        }

        final auth = await _supabaseClient.auth.signInWithIdToken(
          provider: OAuthProvider.apple,
          idToken: idToken,
        );
        if (auth.user == null) {
          developer.log(
            'Supabase 로그인 실패',
            name: 'AuthRepository[authWithApple]',
          );
          throw Exception('Supabase 로그인 실패');
        }
        final authUser = auth.user!;

        final entity = AuthCredentialEntity(
          idToken: idToken,
          providerId: authUser.id,
          provider: OAuthProvider.apple.name,
          email: authUser.email,
          displayName: authUser.userMetadata?['name'] ?? '',
          photoURL: authUser.userMetadata?['picture'] ?? '',
        );
        developer.log(
          'Apple idToken 획득 성공: $entity',
          name: 'AuthRepository[authWithApple]',
        );
        final dto = entity.toDto();
        return dto;
      },
      operationName: 'Apple Sign-In',
      errorMessage: 'Apple 로그인에 실패했습니다',
      handleUserCancellation: true,
    );
  }

  @override
  Future<void> signOut() async {
    await AsyncWrapper.wrap(
      () async {
        developer.log('로그아웃 시작', name: 'AuthRepository[signOut]');
        await _supabaseClient.auth.signOut();
        developer.log('로그아웃 완료', name: 'AuthRepository[signOut]');
      },
      operationName: 'Sign Out',
      errorMessage: '로그아웃에 실패했습니다',
      shouldRethrow: true,
    );
  }

  @override
  Stream<UserDto?> get authStateChanges {
    return _supabaseClient.auth.onAuthStateChange.map((AuthState data) {
      final user = data.session?.user;
      if (user != null) {
        developer.log(
          '인증 상태 변경: 로그인됨 - ${user.email}',
          name: 'AuthRepository[authStateChanges]',
        );
        final entity = UserEntity.fromJson(user.toJson());
        return entity.toDto();
      }
      developer.log(
        '인증 상태 변경: 로그아웃됨',
        name: 'AuthRepository[authStateChanges]',
      );
      return null;
    });
  }
}
