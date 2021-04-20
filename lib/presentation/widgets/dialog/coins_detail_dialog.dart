import 'package:cryptolostapp/application/models/coin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Dialog coinsDetailsDialog(BuildContext context, CoinModel? coinModel) {
  String formattedDate = DateFormat('hh:mm dd/MM/yyyy')
      .format(DateTime.tryParse(coinModel!.last_updated!)!.toLocal());
  String coinPrice = NumberFormat.currency(name: "")
      .format(coinModel.market_data!.current_price!["usd"]);
  String marketCap = NumberFormat.currency(name: "")
      .format(coinModel.market_data!.market_cap!["usd"]);
  String marketCapChange =
      coinModel.market_data!.market_cap_change_24h!.toString();
  String priceChange_24h =
      coinModel.market_data!.price_change_percentage_24h!.toString();
  String priceChange_7d =
      coinModel.market_data!.price_change_percentage_7d!.toString();
  String priceChange_30d =
      coinModel.market_data!.price_change_percentage_30d!.toString();
  String priceChange_200d =
      coinModel.market_data!.price_change_percentage_200d!.toString();

  return Dialog(
    insetPadding: EdgeInsets.all(25),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.65,
      child: ListView(
        children: [
          SizedBox(
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
          Container(
            child: ListTile(
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
          ),
          Container(
            child: ListTile(
              title: Text("Current Price"),
              trailing: Text("\$ " + coinPrice),
            ),
          ),
          Container(
            child: ListTile(
              title: Text("Price Change"),
              subtitle: Text("in 24 Hours"),
              trailing: Text("% " + priceChange_24h),
            ),
          ),
          Container(
            child: ListTile(
              title: Text("Price Change"),
              subtitle: Text("in 7 Days"),
              trailing: Text("% " + priceChange_7d),
            ),
          ),
          Container(
            child: ListTile(
              title: Text("Price Change"),
              subtitle: Text("in 30 Days"),
              trailing: Text("% " + priceChange_30d),
            ),
          ),
          Container(
            child: ListTile(
              title: Text("Price Change"),
              subtitle: Text("in 200 Days"),
              trailing: Text("% " + priceChange_200d),
            ),
          ),
          Container(
            child: ListTile(
              subtitle: Text("(\$)"),
              title: Text(
                "Market Cap",
                textScaleFactor: 0.9,
              ),
              trailing: Text(marketCap),
            ),
          ),
          SizedBox(height: 25),
          Container(
            width: 120,
            child: CupertinoButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    ),
  );
}
