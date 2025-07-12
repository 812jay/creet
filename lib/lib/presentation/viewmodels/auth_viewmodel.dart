import 'package:creet/lib/core/di/providers.dart';
import 'package:creet/lib/domain/entities/user_entity.dart';
import 'package:creet/lib/domain/usecases/auth_usecases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  @override
  Future<UserEntity?> build() async {
    // Initialize with current user
    final useCase = ref.read(getCurrentUserUseCaseProvider);
    return await useCase();
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();

    try {
      final useCase = ref.read(signInWithGoogleUseCaseProvider);
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
}

// UseCase Providers
@riverpod
SignInWithGoogleUseCase signInWithGoogleUseCase(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignInWithGoogleUseCase(authRepository);
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
