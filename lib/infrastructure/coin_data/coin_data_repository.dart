import 'dart:convert';

import 'package:cryptolostapp/application/models/coin_model.dart';
import 'package:cryptolostapp/domains/coindata_domain.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CoinDataRepository with CoinDataDomain {
  @override
  Future<List<CoinModel>> getCoins() async {
    final uri = Uri.parse("https://api.coingecko.com/api/v3/coins/");
    final resp = await http.get(uri);
    final List<dynamic> res = jsonDecode(resp.body) as List<dynamic>;

    final List<CoinModel> coins = List.generate(
        res.length, (index) => CoinModel.fromMap(res.elementAt(index)));

    return coins;
  }

  @override
  Future<CoinModel?> getCoinsSpesificDate(String id, DateTime dateTime) async {
    final String formattedDate = DateFormat("dd-MM-yyyy").format(dateTime);

    final uri = Uri.parse(
        "https://api.coingecko.com/api/v3/coins/$id/history?date=$formattedDate");
    final resp = await http.get(uri);

    return CoinModel.fromJson(resp.body);
  }
}
