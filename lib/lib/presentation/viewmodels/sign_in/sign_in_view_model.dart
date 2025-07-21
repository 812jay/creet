import 'package:creet/lib/core/di/service_locator.dart';
import 'package:creet/lib/domain/entities/user_entity.dart';
import 'package:creet/lib/domain/usecases/auth_usecases.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_view_model.g.dart';

@riverpod
class SignInViewModel extends _$SignInViewModel {
  bool _isSigningIn = false;

  @override
  Future<UserEntity?> build() async {
    final useCase = serviceLocator.get<GetCurrentUserUseCase>();
    return await useCase();
  }

  Future<void> signInWithGoogle() async {
    if (_isSigningIn) return; // 이미 로그인 중이면 중복 실행 방지

    _isSigningIn = true;

    try {
      final useCase = serviceLocator.get<SignInWithGoogleUseCase>();
      final user = await useCase();

      // 사용자가 취소한 경우 (user가 null)
      if (user == null) {
        // 이전 상태로 되돌리기 (로그인 전 상태)
        return;
      }

      state = AsyncValue.data(user);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    } finally {
      _isSigningIn = false;
    }
  }

  Future<void> signInWithApple() async {
    if (_isSigningIn) return; // 이미 로그인 중이면 중복 실행 방지

    _isSigningIn = true;

    try {
      final useCase = serviceLocator.get<SignInWithAppleUseCase>();
      final user = await useCase();

      // 사용자가 취소한 경우 (user가 null)
      if (user == null) {
        // 취소는 정상적인 상황이므로 이전 상태로 되돌리기
        final currentUser = await serviceLocator.get<GetCurrentUserUseCase>()();
        state = AsyncValue.data(currentUser);
        return;
      }

      state = AsyncValue.data(user);
    } catch (error, stackTrace) {
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
