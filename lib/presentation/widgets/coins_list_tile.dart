import 'package:cryptolostapp/application/models/coin.dart';
import 'package:cryptolostapp/presentation/widgets/dialog/coins_detail_dialog.dart';
import 'package:cryptolostapp/utility/analytics/google_anayltics_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoinsListTile extends StatelessWidget {
  final CoinModel? coinModel;
  const CoinsListTile({Key? key, this.coinModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('hh:mm dd/MM/yyyy')
        .format(DateTime.tryParse(coinModel!.last_updated!)!.toLocal());
    final String coinPrice = NumberFormat.currency(name: "")
        .format(coinModel!.market_data!.current_price!["usd"]);

    if (coinModel == null) {
      return Container();
    }
    return ListTile(
      onTap: () async {
        try {
          final dialog = coinsDetailsDialog(context, coinModel);
          await coinsDetailOpenedEvent();
          showDialog(context: context, builder: (context) => dialog);
        } catch (e) {
          print(e);
        }
      },
      leading: Image.network(coinModel!.image!.thumb!),
      subtitle: Text(formattedDate),
      title: Text(coinModel!.name!),
      trailing: Text(
        "\$$coinPrice",
        textScaleFactor: 1.25,
        style: const TextStyle(
          color: Colors.indigo,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
