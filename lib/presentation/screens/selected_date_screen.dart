import 'package:cryptolostapp/application/provider/appstate.dart';
import 'package:cryptolostapp/infrastructure/coins.dart';
import 'package:cryptolostapp/presentation/widgets/coins_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SelectedDateCoinScreen extends StatelessWidget {
  const SelectedDateCoinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: () async {
          try {
            await Future.delayed(Duration(milliseconds: 300));

            final CoinDataRepository coinDataRepository =
                CoinDataRepository(); // Coins Data Repository

            var res = await coinDataRepository.getCoins();
            Provider.of<AppState>(context, listen: false).setCoins(res);
            Fluttertoast.showToast(
                msg: "Refreshed with latest!", gravity: ToastGravity.CENTER);
          } catch (e) {
            print(e);
          }
        },
        child: Consumer<AppState>(
          builder: (context, appstate, _) {
            var coins = appstate.coins;
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
              return Center(
                child: CircleAvatar(),
              );
            }
          },
        ),
      ),
    );
  }
}
