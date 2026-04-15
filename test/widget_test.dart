import 'package:flutter_test/flutter_test.dart';
import 'package:superweb3wallet/app.dart';

void main() {
  testWidgets('Bootstrap screen shows localized title', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SuperWeb3WalletApp());
    await tester.pumpAndSettle();
    expect(find.text('SuperWeb3Wallet'), findsOneWidget);
  });
}
