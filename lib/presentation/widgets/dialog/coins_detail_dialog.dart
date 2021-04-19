import 'package:cryptolostapp/application/models/coin.dart';
import 'package:flutter/material.dart';

Dialog coinsDetailsDialog(CoinModel? coinModel) {
  return Dialog(
    child: ListView(
      children: [
        Text(coinModel!.id!),
        Text(coinModel.last_updated!),
        Text(coinModel.market_data!.current_price.toString()),
      ],
    ),
  );
}
