import 'package:creet/lib/core/di/providers.dart';
import 'package:creet/lib/core/constants/auth_enum.dart';
import 'package:creet/lib/domain/entities/user_entity.dart';
import 'package:creet/lib/domain/usecases/auth_usecases.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  SignInMethod? _lastSignInMethod;

  @override
  Future<UserEntity?> build() async {
    final useCase = ref.read(getCurrentUserUseCaseProvider);
    return await useCase();
  }

  Future<void> signInWithGoogle() async {
    _lastSignInMethod = SignInMethod.google;
    state = const AsyncValue.loading();
    try {
      final useCase = ref.read(signInWithGoogleUseCaseProvider);
      final user = await useCase();
      state = AsyncValue.data(user);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> signInWithApple() async {
    _lastSignInMethod = SignInMethod.apple;
    state = const AsyncValue.loading();
    try {
      final useCase = ref.read(signInWithAppleUseCaseProvider);
      final user = await useCase();
      state = AsyncValue.data(user);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
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
