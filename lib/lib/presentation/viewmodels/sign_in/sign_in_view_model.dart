import 'package:creet/lib/core/di/service_locator.dart';
import 'package:creet/lib/core/utils/exceptions/custom_exception.dart';
import 'package:creet/lib/core/utils/logger.dart';
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
    Logger.info('SignInViewModel 초기화', tag: 'SignInViewModel');
    // 초기 상태는 null (인증되지 않은 상태)
    return null;
  }

  SignInNavigationState get navigationState => _navigationState;

  Future<void> signInWithGoogle() async {
    Logger.info('Google 로그인 시작', tag: 'SignInViewModel');
    _isSigningIn = true;
    state = const AsyncValue.loading();

    try {
      final authUseCase = serviceLocator.get<AuthUseCase>();

      final userUseCase = serviceLocator.get<UserUseCase>();
      final credential = await authUseCase.signInWithGoogle();

      if (credential == null) {
        Logger.error('Google 인증 실패', tag: 'SignInViewModel');
        state = const AsyncValue.data(null);
        return;
      }

      // 인증 성공 후 users 테이블에서 사용자 확인
      Logger.info(
        'Google 인증 성공: ${credential.email ?? "이메일 없음"}',
        tag: 'SignInViewModel',
      );

      // users 테이블에서 기존 사용자인지 확인
      final existingUser = await userUseCase.getCurrentUser();

      if (existingUser != null) {
        // 기존 사용자: 메인 페이지로 이동
        Logger.info(
          '기존 사용자 확인됨: ${existingUser.email}',
          tag: 'SignInViewModel',
        );
        state = AsyncValue.data(credential);
        _navigationState = SignInNavigationState.toMain;
      } else {
        // 새 사용자: 이용약관 페이지로 이동
        Logger.info('새 사용자: 이용약관 페이지로 이동', tag: 'SignInViewModel');
        state = AsyncValue.data(credential);
        _navigationState = SignInNavigationState.toTerms;
      }
    } catch (error, stackTrace) {
      // 사용자 취소는 에러가 아닌 정상적인 상황
      if (error is CustomException && error.code == 'USER_CANCELLED') {
        Logger.info('Google 로그인 취소됨', tag: 'SignInViewModel');
        state = const AsyncValue.data(null);
      } else {
        Logger.error('Google 인증 실패: $error', tag: 'SignInViewModel');
        state = AsyncValue.error(error, stackTrace);
      }
    } finally {
      _isSigningIn = false;
    }
  }

  Future<void> signInWithApple() async {
    if (_isSigningIn) {
      Logger.info('이미 인증 중이므로 중복 실행 방지', tag: 'SignInViewModel');
      return;
    }

    Logger.info('Apple 로그인 시작', tag: 'SignInViewModel');
    _isSigningIn = true;
    state = const AsyncValue.loading();

    try {
      final authUseCase = serviceLocator.get<AuthUseCase>();
      final userUseCase = serviceLocator.get<UserUseCase>();
      final credential = await authUseCase.signInWithApple();

      if (credential == null) {
        Logger.error('Apple 인증 실패', tag: 'SignInViewModel');
        state = const AsyncValue.data(null);
        return;
      }

      // 인증 성공 후 users 테이블에서 사용자 확인
      Logger.info('Apple 인증 성공: ${credential.email}', tag: 'SignInViewModel');

      // users 테이블에서 기존 사용자인지 확인
      final existingUser = await userUseCase.getCurrentUser();

      if (existingUser != null) {
        // 기존 사용자: 메인 페이지로 이동
        Logger.info(
          '기존 사용자 확인됨: ${existingUser.email}',
          tag: 'SignInViewModel',
        );
        state = AsyncValue.data(credential);
        _navigationState = SignInNavigationState.toMain;
      } else {
        // 새 사용자: 이용약관 페이지로 이동
        Logger.info('새 사용자: 이용약관 페이지로 이동', tag: 'SignInViewModel');
        state = AsyncValue.data(credential);
        _navigationState = SignInNavigationState.toTerms;
      }
    } catch (error, stackTrace) {
      // 사용자 취소는 에러가 아닌 정상적인 상황
      if (error is CustomException && error.code == 'USER_CANCELLED') {
        Logger.info('Apple 로그인 취소됨', tag: 'SignInViewModel');
        state = const AsyncValue.data(null);
      } else {
        Logger.error('Apple 인증 실패: $error', tag: 'SignInViewModel');
        state = AsyncValue.error(error, stackTrace);
      }
    } finally {
      _isSigningIn = false;
    }
  }

  bool get isSigningIn => _isSigningIn; // 인증 진행 중 상태

  // iOS에서만 Apple 로그인 사용 가능
  bool get isAppleSignInAvailable =>
      defaultTargetPlatform == TargetPlatform.iOS;
}
