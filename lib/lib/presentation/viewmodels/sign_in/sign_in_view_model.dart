import 'dart:developer' as developer;
import 'package:creet/lib/core/di/service_locator.dart';
import 'package:creet/lib/domain/dto/auth/auth_credential_dto.dart';
import 'package:creet/lib/domain/usecases/auth_usecases.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_view_model.g.dart';

@riverpod
class SignInViewModel extends _$SignInViewModel {
  bool _isSigningIn = false;

  @override
  Future<AuthCredentialDto?> build() async {
    developer.log('SignInViewModel 초기화', name: 'SignInViewModel');
    // 초기 상태는 null (인증되지 않은 상태)
    return null;
  }

  Future<void> signInWithGoogle() async {
    developer.log('Google 로그인 시작', name: 'SignInViewModel');
    _isSigningIn = true;
    state = const AsyncValue.loading();

    try {
      final useCase = serviceLocator.get<SignInWithGoogleUseCase>();
      final credential = await useCase();

      if (credential == null) {
        throw Exception('Google 인증 실패');
      }

      // 인증 성공 시 이용약관 페이지로 이동
      developer.log(
        'Google 인증 성공: ${credential.email ?? "이메일 없음"}',
        name: 'SignInViewModel',
      );
      state = AsyncValue.data(credential);

      // 이용약관 페이지로 이동 (context가 필요하므로 별도 메서드로 처리)
      _navigateToTermsOfService(credential);
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
      final useCase = serviceLocator.get<SignInWithAppleUseCase>();
      final credential = await useCase();

      if (credential == null) {
        throw Exception('Apple 인증 실패');
      }

      // 인증 성공 시 이용약관 페이지로 이동
      developer.log(
        'Apple 인증 성공: ${credential.email}',
        name: 'SignInViewModel',
      );
      state = AsyncValue.data(credential);

      // 이용약관 페이지로 이동
      _navigateToTermsOfService(credential);
    } catch (error, stackTrace) {
      developer.log('Apple 인증 실패: $error', name: 'SignInViewModel');
      state = AsyncValue.error(error, stackTrace);
    } finally {
      _isSigningIn = false;
    }
  }

  void _navigateToTermsOfService(AuthCredentialDto credential) {
    // TODO: 실제 네비게이션 구현
    // Navigator.of(context).pushNamed('/terms', arguments: {'credential': credential});
    developer.log('이용약관 페이지로 이동 예정', name: 'SignInViewModel');
  }

  bool get isSigningIn => _isSigningIn; // 인증 진행 중 상태

  // iOS에서만 Apple 로그인 사용 가능
  bool get isAppleSignInAvailable =>
      defaultTargetPlatform == TargetPlatform.iOS;
}
