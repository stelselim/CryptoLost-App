import 'package:cryptolostapp/application/models/coin.dart';

abstract class CoinDataDomain {
  Future<List<CoinModel>> getCoins();

  Future<CoinModel?> getCoinsSpesificDate(String id, DateTime dateTime);
}
