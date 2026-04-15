import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:superweb3wallet/domain/repositories/network_repository.dart';
import 'package:superweb3wallet/domain/repositories/wallet_repository.dart';
import 'package:superweb3wallet/domain/usecases/fetch_portfolio_balance_usecase.dart';
import 'package:superweb3wallet/l10n/app_localizations.dart';
import 'package:superweb3wallet/presentation/screens/accounts/accounts_screen.dart';
import 'package:superweb3wallet/presentation/screens/receive/receive_screen.dart';
import 'package:superweb3wallet/presentation/screens/send/send_screen.dart';
import 'package:superweb3wallet/presentation/widgets/identicon/wallet_identicon.dart';
import 'package:superweb3wallet/presentation/widgets/network/network_selector_sheet.dart';

/// Primary wallet dashboard after onboarding completes.
class WalletHomeScreen extends StatefulWidget {
  /// Route path for wallet home.
  static const String routePath = '/home';

  /// Named route identifier.
  static const String routeName = 'home';

  /// Creates wallet home UI.
  const WalletHomeScreen({super.key});

  @override
  State<WalletHomeScreen> createState() => _WalletHomeScreenState();
}

class _WalletHomeScreenState extends State<WalletHomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs =
      TabController(length: 4, vsync: this, initialIndex: 0);

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final WalletRepository wallet = context.read<WalletRepository>();
    final NetworkRepository networks = context.read<NetworkRepository>();
    final FetchPortfolioBalanceUseCase portfolio =
        FetchPortfolioBalanceUseCase(networks);
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<String?>(
          future: wallet.primaryAddress(),
          builder: (BuildContext context, AsyncSnapshot<String?> snap) {
            final String addr = snap.data ?? '';
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FutureBuilder<int>(
                          future: networks.activeChainId(),
                          builder: (BuildContext context, AsyncSnapshot<int> id) {
                            return FilledButton.tonal(
                              onPressed: () => showNetworkSelectorSheet(
                                context: context,
                                networks: networks,
                              ),
                              child: Text('Chain ${id.data ?? '…'}'),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      WalletIdenticon(address: addr),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_none),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text(l10n.homeAccountName),
                  subtitle: SelectableText(addr.isEmpty ? '—' : addr),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {},
                  ),
                  onTap: () => context.push(AccountsScreen.routePath),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FutureBuilder<double>(
                    future: portfolio.call(address: addr),
                    builder: (BuildContext context, AsyncSnapshot<double> bal) {
                      final double usd = bal.data ?? 0;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '\$${usd.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(l10n.homeChange24h),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.push(SendScreen.routePath),
                          child: Text(l10n.actionSend),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.push(ReceiveScreen.routePath),
                          child: Text(l10n.actionReceive),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(l10n.actionBuy),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(l10n.actionSwap),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(l10n.actionBridge),
                        ),
                      ),
                    ],
                  ),
                ),
                TabBar(
                  controller: _tabs,
                  tabs: <Tab>[
                    Tab(text: l10n.tabTokens),
                    Tab(text: l10n.tabNfts),
                    Tab(text: l10n.tabActivity),
                    Tab(text: l10n.tabDeFi),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabs,
                    children: <Widget>[
                      Center(child: Text(l10n.tokensEmpty)),
                      Center(child: Text(l10n.nftsEmpty)),
                      Center(child: Text(l10n.activityEmpty)),
                      Center(child: Text(l10n.deFiComingSoon)),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
