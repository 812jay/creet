import 'package:creet/lib/core/di/providers.dart';
import 'package:creet/lib/core/constants/auth_enum.dart';
import 'package:creet/lib/domain/entities/user_entity.dart';
import 'package:creet/lib/domain/usecases/auth_usecases.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_view_model.g.dart';

@riverpod
class SignInViewModel extends _$SignInViewModel {
  SignInMethod? _lastSignInMethod;
  bool _isSigningIn = false;

  @override
  Future<UserEntity?> build() async {
    final useCase = ref.read(getCurrentUserUseCaseProvider);
    return await useCase();
  }

  Future<void> signInWithGoogle() async {
    if (_isSigningIn) return; // 이미 로그인 중이면 중복 실행 방지

    _lastSignInMethod = SignInMethod.google;
    _isSigningIn = true;

    try {
      final useCase = ref.read(signInWithGoogleUseCaseProvider);
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

    _lastSignInMethod = SignInMethod.apple;
    _isSigningIn = true;

    try {
      final useCase = ref.read(signInWithAppleUseCaseProvider);
      final user = await useCase();

      // 사용자가 취소한 경우 (user가 null)
      if (user == null) {
        // 취소는 정상적인 상황이므로 이전 상태로 되돌리기
        final currentUser = await ref.read(getCurrentUserUseCaseProvider)();
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

  Future<void> signOut() async {
    try {
      final useCase = ref.read(signOutUseCaseProvider);
      await useCase();
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  bool get isSignedIn => state.value != null;
  UserEntity? get currentUser => state.value;
  bool get isSigningIn => _isSigningIn; // 로그인 진행 중 상태

  // iOS에서만 Apple 로그인 사용 가능
  bool get isAppleSignInAvailable =>
      defaultTargetPlatform == TargetPlatform.iOS;

  // 마지막 시도한 로그인 방법으로 재시도
  Future<void> retryLastSignIn() async {
    if (_lastSignInMethod != null) {
      switch (_lastSignInMethod!) {
        case SignInMethod.google:
          await signInWithGoogle();
          break;
        case SignInMethod.apple:
          await signInWithApple();
          break;
      }
    }
  }
}

// UseCase Providers
@riverpod
SignInWithGoogleUseCase signInWithGoogleUseCase(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignInWithGoogleUseCase(authRepository);
}

@riverpod
SignInWithAppleUseCase signInWithAppleUseCase(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignInWithAppleUseCase(authRepository);
}

@riverpod
SignOutUseCase signOutUseCase(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignOutUseCase(authRepository);
}

@riverpod
GetCurrentUserUseCase getCurrentUserUseCase(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GetCurrentUserUseCase(authRepository);
}

@riverpod
GetAuthStateChangesUseCase getAuthStateChangesUseCase(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GetAuthStateChangesUseCase(authRepository);
}
