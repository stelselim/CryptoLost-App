import 'dart:convert';

import 'package:http/http.dart' as http;

Future getCurrentCoinExchanges() async {
  var uri = Uri.parse("https://api.coingecko.com/api/v3/coins/");
  var resp = await http.get(uri);
  var res = jsonDecode(resp.body);
  print(res[0]);
  // print(res[1]);
}
