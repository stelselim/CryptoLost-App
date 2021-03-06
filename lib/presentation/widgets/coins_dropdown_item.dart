import 'package:cryptolostapp/application/models/coin_model.dart';
import 'package:flutter/material.dart';

List<DropdownMenuItem<CoinModel>>? coinsDropDown(List<CoinModel>? coinModels) {
  final List<DropdownMenuItem<CoinModel>> items = [];
  if (coinModels == null) {
    return [];
  }
  coinModels.forEach((element) {
    if (element.id != null) {
      items.add(DropdownMenuItem(
        key: Key(element.id.toString()),
        value: element,
        child: Text(
          element.symbol!.toUpperCase(),
        ),
      ));
    }
  });
  return items;
}
