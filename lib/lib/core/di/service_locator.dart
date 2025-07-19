import 'package:creet/lib/core/services/auth_service.dart';
import 'package:creet/lib/data/repositories/auth_repository_impl.dart';
import 'package:creet/lib/domain/repositories/auth_repository.dart';
import 'package:creet/lib/domain/usecases/auth_usecases.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Global Service Locator instance
final GetIt serviceLocator = GetIt.instance;

/// Service Locator 초기화
class ServiceLocator {
  static Future<void> initialize() async {
    // Core Services
    _registerCoreServices();

    // Repositories
    _registerRepositories();

    // Use Cases
    _registerUseCases();
  }

  /// Core Services 등록
  static void _registerCoreServices() {
    // Supabase Client
    serviceLocator.registerLazySingleton<SupabaseClient>(
      () => Supabase.instance.client,
    );

    // Dio HTTP Client
    serviceLocator.registerLazySingleton<Dio>(() {
      final dio = Dio();
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
      return dio;
    });

    // SharedPreferences
    serviceLocator.registerLazySingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance(),
    );

    // Auth Service
    serviceLocator.registerLazySingleton<AuthService>(() => AuthService());
  }

  /// Repositories 등록
  static void _registerRepositories() {
    // Auth Repository
    serviceLocator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator<SupabaseClient>()),
    );
  }

  /// Use Cases 등록
  static void _registerUseCases() {
    // Auth Use Cases
    serviceLocator.registerLazySingleton<SignInWithGoogleUseCase>(
      () => SignInWithGoogleUseCase(serviceLocator<AuthRepository>()),
    );

    serviceLocator.registerLazySingleton<SignInWithAppleUseCase>(
      () => SignInWithAppleUseCase(serviceLocator<AuthRepository>()),
    );

    serviceLocator.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(serviceLocator<AuthRepository>()),
    );

    serviceLocator.registerLazySingleton<GetCurrentUserUseCase>(
      () => GetCurrentUserUseCase(serviceLocator<AuthRepository>()),
    );

    serviceLocator.registerLazySingleton<GetAuthStateChangesUseCase>(
      () => GetAuthStateChangesUseCase(serviceLocator<AuthRepository>()),
    );
  }

  /// Service Locator 리셋 (테스트용)
  static Future<void> reset() async {
    await serviceLocator.reset();
  }
}

/// Extension for easier access to services
extension ServiceLocatorExtension on GetIt {
  T get<T extends Object>() => call<T>();
  Future<T> getAsync<T extends Object>() => call<Future<T>>();
}
