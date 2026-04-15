import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/router/app_router.dart';
import 'data/datasources/wallet_secure_storage.dart';
import 'data/repositories/wallet_repository_impl.dart';
import 'domain/repositories/wallet_repository.dart';

/// Application entrypoint: initializes storage then runs the app widget.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  const FlutterSecureStorage storage = FlutterSecureStorage();
  final WalletSecureStorage walletStorage = WalletSecureStorage(storage);
  final WalletRepository repository = WalletRepositoryImpl(walletStorage);
  final GoRouter router = AppRouter.createRouter();
  runApp(
    RepositoryProvider<WalletRepository>.value(
      value: repository,
      child: SuperWeb3WalletApp(router: router),
    ),
  );
}
