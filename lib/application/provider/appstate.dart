import 'package:cryptolostapp/application/models/coin.dart';
import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  int index = 0;
  List<CoinModel>? coins; // Coins from API
  List<CoinModel> selectedDateCoins = []; // Coins at Selected Date;

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

  setSelectedDateCoins(List<CoinModel> newCoins) {
    if (selectedDateCoins == newCoins) return;
    selectedDateCoins = newCoins;
    notifyListeners();
  }
}
