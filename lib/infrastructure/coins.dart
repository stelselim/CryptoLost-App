import 'dart:convert';

import 'package:cryptolostapp/application/models/coin.dart';
import 'package:cryptolostapp/domains/coindata_domain.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CoinDataRepository with CoinDataDomain {
  @override
  Future<List<CoinModel>> getCoins() async {
    final uri = Uri.parse("https://api.coingecko.com/api/v3/coins/");
    var resp = await http.get(uri);
    List<dynamic> res = jsonDecode(resp.body);

    List<CoinModel> coins = List.generate(
        res.length, (index) => CoinModel.fromMap(res.elementAt(index)));

    return coins;
  }

  @override
  Future<CoinModel?> getCoinsSpesificDate(String id, DateTime dateTime) async {
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

    final uri = Uri.parse(
        "https://api.coingecko.com/api/v3/coins/$id/history?date=$formattedDate");
    var resp = await http.get(uri);

    return CoinModel.fromJson(resp.body);
  }
}
