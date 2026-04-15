import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/local_auth.dart';

import 'app.dart';
import 'core/router/app_router.dart';
import 'core/security/local_auth_service.dart';
import 'data/datasources/preferences_storage.dart';
import 'data/datasources/wallet_secure_storage.dart';
import 'data/repositories/wallet_repository_impl.dart';
import 'domain/repositories/wallet_repository.dart';
import 'presentation/blocs/theme/theme_cubit.dart';
import 'presentation/security/app_lock_controller.dart';

/// Application entrypoint: initializes storage then runs the app widget.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final PreferencesStorage preferences = PreferencesStorage();
  await preferences.init();
  const FlutterSecureStorage storage = FlutterSecureStorage();
  final WalletSecureStorage walletStorage = WalletSecureStorage(storage);
  final WalletRepository repository = WalletRepositoryImpl(walletStorage);
  final ThemeCubit themeCubit = ThemeCubit(preferences);
  final AppLockController appLock = AppLockController(preferences);
  appLock.attach();
  final LocalAuthService localAuth = LocalAuthService(LocalAuthentication());
  final GoRouter router = AppRouter.createRouter(appLock: appLock);
  runApp(
    MultiRepositoryProvider(
      providers: <RepositoryProvider<dynamic>>[
        RepositoryProvider<WalletRepository>.value(value: repository),
        RepositoryProvider<AppLockController>.value(value: appLock),
        RepositoryProvider<LocalAuthService>.value(value: localAuth),
      ],
      child: BlocProvider<ThemeCubit>.value(
        value: themeCubit,
        child: SuperWeb3WalletApp(router: router),
      ),
    ),
  );
}
