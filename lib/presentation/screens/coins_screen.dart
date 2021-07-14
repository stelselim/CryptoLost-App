import 'package:cryptolostapp/application/provider/appstate.dart';
import 'package:cryptolostapp/infrastructure/coin_data/coin_data_repository.dart';
import 'package:cryptolostapp/presentation/widgets/coins_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CoinsScreen extends StatelessWidget {
  const CoinsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        try {
          await Future.delayed(const Duration(milliseconds: 300));

          final CoinDataRepository coinDataRepository =
              CoinDataRepository(); // Coins Data Repository

          final res = await coinDataRepository.getCoins();
          Provider.of<AppState>(context, listen: false).setCoins(res);
          Fluttertoast.showToast(
              msg: "Refreshed with latest!", gravity: ToastGravity.CENTER);
        } catch (e) {
          print(e);
        }
      },
      child: Consumer<AppState>(
        builder: (context, appstate, _) {
          final coins = appstate.coins;
          if (coins != null && coins.isNotEmpty) {
            return ListView.builder(
              itemCount: coins.length,
              itemBuilder: (context, index) {
                return CoinsListTile(
                  coinModel: coins.elementAt(index),
                );
              },
            );
          } else {
            return const Center(
              child: CircleAvatar(),
            );
          }
        },
      ),
    );
  }
}
