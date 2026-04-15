import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:superweb3wallet/app.dart';
import 'package:superweb3wallet/core/router/app_router.dart';
import 'package:superweb3wallet/domain/repositories/wallet_repository.dart';

import 'support/fake_wallet_repository.dart';

void main() {
  testWidgets('Cold start navigates to onboarding when no wallet', (
    WidgetTester tester,
  ) async {
    final FakeWalletRepository repo = FakeWalletRepository(hasWalletValue: false);
    await tester.pumpWidget(
      RepositoryProvider<WalletRepository>.value(
        value: repo,
        child: SuperWeb3WalletApp(router: AppRouter.createRouter()),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(repo.hasWalletValue, isFalse);
    expect(find.text('Create a New Wallet'), findsOneWidget);
  });
}
