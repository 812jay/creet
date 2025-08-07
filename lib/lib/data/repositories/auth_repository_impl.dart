import 'dart:async';

import 'package:creet/lib/core/utils/exceptions/async_wrapper.dart';
import 'package:creet/lib/core/utils/logger.dart';
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
        Logger.info('Google Sign-In 시작', tag: 'AuthRepository');

        // Google Sign-In 초기화
        final GoogleSignIn googleSignIn = GoogleSignIn.instance;
        unawaited(
          googleSignIn.initialize(
            serverClientId: dotenv.env['GOOGLE_WEB_CLIENT_ID'] ?? '',
          ),
        );

        Logger.info('Google Sign-In 인증 시도', tag: 'AuthRepository');
        // Google Sign-In 실행
        final GoogleSignInAccount googleUser =
            await googleSignIn.authenticate();

        // idToken 획득
        final GoogleSignInAuthentication googleAuth = googleUser.authentication;
        final String? idToken = googleAuth.idToken;

        if (idToken == null) {
          Logger.warning('Google idToken 획득 실패', tag: 'AuthRepository');
          throw Exception('Google idToken 획득 실패');
        }

        final response = await _supabaseClient.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: idToken,
        );
        final authUser = response.user!;

        final credential = AuthCredentialDto(
          idToken: idToken,
          providerId: authUser.id,
          provider: OAuthProvider.google.name,
          email: authUser.email,
          displayName: authUser.userMetadata?['name'] ?? '',
          photoURL: authUser.userMetadata?['picture'] ?? '',
        );
        return credential;
      },
      operationName: 'Google Sign-In',
      errorMessage: 'Google 로그인에 실패했습니다',
      handleUserCancellation: true,
    );
  }

  @override
  Future<AuthCredentialDto?> signinWithApple() async {
    return AsyncWrapper.wrap(
      () async {
        Logger.info('Apple Sign-In 시작', tag: 'AuthRepository');

        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        final String idToken = credential.identityToken ?? '';

        if (idToken == '') {
          Logger.info('Apple Sign-In 취소됨', tag: 'AuthRepository');
          throw Exception('Apple Sign-In 취소됨');
        }

        final auth = await _supabaseClient.auth.signInWithIdToken(
          provider: OAuthProvider.apple,
          idToken: idToken,
        );
        if (auth.user == null) {
          Logger.error('Supabase 로그인 실패', tag: 'AuthRepository');
          throw Exception('Supabase 로그인 실패');
        }
        final authUser = auth.user!;

        final authCredential = AuthCredentialDto(
          idToken: idToken,
          providerId: authUser.id,
          provider: OAuthProvider.apple.name,
          email: authUser.email,
          displayName: authUser.userMetadata?['name'] ?? '',
          photoURL: authUser.userMetadata?['picture'] ?? '',
        );
        Logger.info(
          'Apple idToken 획득 성공: $authCredential',
          tag: 'AuthRepository',
        );
        return authCredential;
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
        Logger.info('로그아웃 시작', tag: 'AuthRepository');
        await _supabaseClient.auth.signOut();
        Logger.info('로그아웃 완료', tag: 'AuthRepository');
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
        Logger.info('인증 상태 변경: 로그인됨 - ${user.email}', tag: 'AuthRepository');
        return UserDto.fromJson(user.toJson());
      }
      Logger.info('인증 상태 변경: 로그아웃됨', tag: 'AuthRepository');
      return null;
    });
  }
}
