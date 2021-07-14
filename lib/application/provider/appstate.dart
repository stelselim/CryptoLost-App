import 'package:cryptolostapp/application/models/coin_model.dart';
import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  int index = 0; // BottomBar Index
  List<CoinModel>? coins; // Coins from API
  List<CoinModel> selectedDateCoins = []; // Coins at Selected Date;

  void updateIndex(int newIndex) {
    if (index == newIndex) return;
    index = newIndex;
    notifyListeners();
  }

  void setCoins(List<CoinModel>? newCoins) {
    if (coins == newCoins) return;
    coins = newCoins;
    notifyListeners();
  }

  void setSelectedDateCoins(List<CoinModel> newCoins) {
    if (selectedDateCoins == newCoins) return;
    selectedDateCoins = newCoins;
    notifyListeners();
  }
}
