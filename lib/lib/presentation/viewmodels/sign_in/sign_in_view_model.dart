import 'dart:developer' as developer;
import 'package:creet/lib/core/di/service_locator.dart';
import 'package:creet/lib/domain/dto/auth/auth_credential_dto.dart';
import 'package:creet/lib/domain/usecases/auth_usecases.dart';
import 'package:creet/lib/domain/usecases/user_usecases.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_view_model.g.dart';

enum SignInNavigationState { none, toMain, toTerms }

@riverpod
class SignInViewModel extends _$SignInViewModel {
  bool _isSigningIn = false;
  SignInNavigationState _navigationState = SignInNavigationState.none;

  @override
  Future<AuthCredentialDto?> build() async {
    developer.log('SignInViewModel 초기화', name: 'SignInViewModel');
    // 초기 상태는 null (인증되지 않은 상태)
    return null;
  }

  SignInNavigationState get navigationState => _navigationState;

  Future<void> signInWithGoogle() async {
    developer.log('Google 로그인 시작', name: 'SignInViewModel');
    _isSigningIn = true;
    state = const AsyncValue.loading();

    try {
      final signInWithGoogleUseCase =
          serviceLocator.get<SignInWithGoogleUseCase>();
      final userUseCase = serviceLocator.get<GetCurrentUserUseCase>();
      final credential = await signInWithGoogleUseCase();

      if (credential == null) {
        throw Exception('Google 인증 실패');
      }

      // 인증 성공 후 users 테이블에서 사용자 확인
      developer.log(
        'Google 인증 성공: ${credential.email ?? "이메일 없음"}',
        name: 'SignInViewModel',
      );

      // users 테이블에서 기존 사용자인지 확인
      final existingUser = await userUseCase();

      if (existingUser != null) {
        // 기존 사용자: 메인 페이지로 이동
        developer.log(
          '기존 사용자 확인됨: ${existingUser.email}',
          name: 'SignInViewModel',
        );
        state = AsyncValue.data(credential);
        _navigationState = SignInNavigationState.toMain;
      } else {
        // 새 사용자: 이용약관 페이지로 이동
        developer.log('새 사용자: 이용약관 페이지로 이동', name: 'SignInViewModel');
        state = AsyncValue.data(credential);
        _navigationState = SignInNavigationState.toTerms;
      }
    } catch (error, stackTrace) {
      developer.log('Google 인증 실패: $error', name: 'SignInViewModel');
      state = AsyncValue.error(error, stackTrace);
    } finally {
      _isSigningIn = false;
    }
  }

  Future<void> signInWithApple() async {
    if (_isSigningIn) {
      developer.log('이미 인증 중이므로 중복 실행 방지', name: 'SignInViewModel');
      return;
    }

    developer.log('Apple 로그인 시작', name: 'SignInViewModel');
    _isSigningIn = true;
    state = const AsyncValue.loading();

    try {
      final signInWithAppleUseCase =
          serviceLocator.get<SignInWithAppleUseCase>();
      final userUseCase = serviceLocator.get<GetCurrentUserUseCase>();
      final credential = await signInWithAppleUseCase();

      if (credential == null) {
        throw Exception('Apple 인증 실패');
      }

      // 인증 성공 후 users 테이블에서 사용자 확인
      developer.log(
        'Apple 인증 성공: ${credential.email}',
        name: 'SignInViewModel',
      );

      // users 테이블에서 기존 사용자인지 확인
      final existingUser = await userUseCase();

      if (existingUser != null) {
        // 기존 사용자: 메인 페이지로 이동
        developer.log(
          '기존 사용자 확인됨: ${existingUser.email}',
          name: 'SignInViewModel',
        );
        state = AsyncValue.data(credential);
        _navigationState = SignInNavigationState.toMain;
      } else {
        // 새 사용자: 이용약관 페이지로 이동
        developer.log('새 사용자: 이용약관 페이지로 이동', name: 'SignInViewModel');
        state = AsyncValue.data(credential);
        _navigationState = SignInNavigationState.toTerms;
      }
    } catch (error, stackTrace) {
      developer.log('Apple 인증 실패: $error', name: 'SignInViewModel');
      state = AsyncValue.error(error, stackTrace);
    } finally {
      _isSigningIn = false;
    }
  }

  bool get isSigningIn => _isSigningIn; // 인증 진행 중 상태

  // iOS에서만 Apple 로그인 사용 가능
  bool get isAppleSignInAvailable =>
      defaultTargetPlatform == TargetPlatform.iOS;
}
