import 'package:cryptolostapp/application/models/coin.dart';
import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  int index = 0;
  List<CoinModel>? coins; // Coins from API

  updateIndex(int newIndex) {
    if (index == newIndex) return;
    index = newIndex;
    notifyListeners();
  }

  setCoins(List<CoinModel>? newCoins) {
    if (coins == newCoins) return;
    coins = newCoins;
    notifyListeners();
  }
}
