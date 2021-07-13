import 'package:cryptolostapp/application/models/coin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Dialog coinsDetailsDialog(BuildContext context, CoinModel? coinModel) {
  final String coinPrice = NumberFormat.currency(name: "")
      .format(coinModel!.market_data!.current_price!["usd"]);
  final String marketCap = NumberFormat.currency(name: "")
      .format(coinModel.market_data!.market_cap!["usd"]);

  final String priceChange_24h =
      coinModel.market_data!.price_change_percentage_24h!.toString();
  final String priceChange_7d =
      coinModel.market_data!.price_change_percentage_7d!.toString();
  final String priceChange_30d =
      coinModel.market_data!.price_change_percentage_30d!.toString();
  final String priceChange_200d =
      coinModel.market_data!.price_change_percentage_200d!.toString();

  return Dialog(
    insetPadding: const EdgeInsets.all(25),
    child: ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            coinModel.image!.large!,
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.2,
          ),
        ),
        ListTile(
          title: Text(
            coinModel.name!,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey.shade800,
            ),
          ),
          trailing: Text(
            "Rank: ${coinModel.market_data!.market_cap_rank}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey.shade800,
            ),
          ),
        ),
        ListTile(
          trailing: Text("\$ $coinPrice"),
          title: const Text("Current Price"),
        ),
        ListTile(
          title: const Text("Price Change"),
          subtitle: const Text("in 24 Hours"),
          trailing: Text("% $priceChange_24h"),
        ),
        ListTile(
          title: const Text("Price Change"),
          subtitle: const Text("in 7 Days"),
          trailing: Text("% $priceChange_7d"),
        ),
        ListTile(
          title: const Text("Price Change"),
          subtitle: const Text("in 30 Days"),
          trailing: Text("% $priceChange_30d"),
        ),
        ListTile(
          title: const Text("Price Change"),
          subtitle: const Text("in 200 Days"),
          trailing: Text("% $priceChange_200d"),
        ),
        ListTile(
          subtitle: const Text("(\$)"),
          title: const Text(
            "Market Cap",
            textScaleFactor: 0.9,
          ),
          trailing: Text(marketCap),
        ),
        const SizedBox(height: 25),
        SizedBox(
          width: 120,
          child: CupertinoButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ),
        const SizedBox(height: 25),
      ],
    ),
  );
}
