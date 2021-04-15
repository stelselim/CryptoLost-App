import 'package:cryptolostapp/application/models/coin.dart';
import 'package:flutter/material.dart';

List<DropdownMenuItem> coinsDropDown(List<CoinModel>? coinModel) {
  if (coinModel == null) {
    return [];
  }
  return coinModel
      .map(
        (e) => DropdownMenuItem(
          value: e.id,
          child: Text(
            e.id,
          ),
        ),
      )
      .toList();
}
