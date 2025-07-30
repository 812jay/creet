import 'dart:developer' as developer;
import 'package:creet/lib/core/di/service_locator.dart';
import 'package:creet/lib/domain/dto/user/user_dto.dart';
import 'package:creet/lib/domain/usecases/auth_usecases.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_view_model.g.dart';

@riverpod
class SignInViewModel extends _$SignInViewModel {
  bool _isSigningIn = false;

  @override
  Future<UserDto?> build() async {
    developer.log('SignInViewModel 초기화', name: 'SignInViewModel');
    final useCase = serviceLocator.get<GetCurrentUserUseCase>();
    final user = await useCase();
    developer.log(
      '현재 사용자 상태: ${user?.email ?? "로그인되지 않음"}',
      name: 'SignInViewModel',
    );
    return user;
  }

  Future<void> signInWithGoogle() async {
    developer.log('Google 로그인 시작', name: 'SignInViewModel');
    _isSigningIn = true;
    state = const AsyncValue.loading();

    try {
      final useCase = serviceLocator.get<SignInWithGoogleUseCase>();
      final user = await useCase();

      // 사용자가 취소한 경우 (user가 null)
      if (user == null) {
        developer.log('Google 로그인 취소됨', name: 'SignInViewModel');
        // 이전 상태로 되돌리기 (로그인 전 상태)
        final currentUser = await serviceLocator.get<GetCurrentUserUseCase>()();
        state = AsyncValue.data(currentUser);
        return;
      }

      // 로그인 성공 시 상태 업데이트
      developer.log('Google 로그인 성공: ${user.email}', name: 'SignInViewModel');
      state = AsyncValue.data(user);
    } catch (error, stackTrace) {
      developer.log('Google 로그인 실패: $error', name: 'SignInViewModel');
      state = AsyncValue.error(error, stackTrace);
    } finally {
      _isSigningIn = false;
    }
  }

  Future<void> signInWithApple() async {
    if (_isSigningIn) {
      developer.log('이미 로그인 중이므로 중복 실행 방지', name: 'SignInViewModel');
      return;
    }

    developer.log('Apple 로그인 시작', name: 'SignInViewModel');
    _isSigningIn = true;
    state = const AsyncValue.loading();

    try {
      final useCase = serviceLocator.get<SignInWithAppleUseCase>();
      final user = await useCase();

      // 사용자가 취소한 경우 (user가 null)
      if (user == null) {
        developer.log('Apple 로그인 취소됨', name: 'SignInViewModel');
        // 취소는 정상적인 상황이므로 이전 상태로 되돌리기
        final currentUser = await serviceLocator.get<GetCurrentUserUseCase>()();
        state = AsyncValue.data(currentUser);
        return;
      }

      // 로그인 성공 시 상태 업데이트
      developer.log('Apple 로그인 성공: ${user.email}', name: 'SignInViewModel');
      state = AsyncValue.data(user);
    } catch (error, stackTrace) {
      developer.log('Apple 로그인 실패: $error', name: 'SignInViewModel');
      state = AsyncValue.error(error, stackTrace);
    } finally {
      _isSigningIn = false;
    }
  }

  bool get isSigningIn => _isSigningIn; // 로그인 진행 중 상태

  // iOS에서만 Apple 로그인 사용 가능
  bool get isAppleSignInAvailable =>
      defaultTargetPlatform == TargetPlatform.iOS;
}
