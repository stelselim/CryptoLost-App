import 'package:cryptolostapp/application/models/coin.dart';

abstract class CoinDataDomain {
  Future<List<CoinModel>> getCoins();
}
