import 'package:flutter_test/flutter_test.dart';
import 'package:superweb3wallet/data/models/chain_network.dart';

void main() {
  test('ChainNetwork.parseList reads bundled JSON shape', () {
    const String json = '[{"name":"Ethereum","chainId":1,"rpcUrl":"https://x","symbol":"ETH","explorer":"https://etherscan.io"}]';
    final List<ChainNetwork> nets = ChainNetwork.parseList(json);
    expect(nets.length, 1);
    expect(nets.first.chainId, 1);
    expect(nets.first.symbol, 'ETH');
  });
}
