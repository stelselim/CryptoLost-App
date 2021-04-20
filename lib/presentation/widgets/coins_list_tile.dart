import 'package:cryptolostapp/application/models/coin.dart';
import 'package:cryptolostapp/presentation/widgets/dialog/coins_detail_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoinsListTile extends StatelessWidget {
  final CoinModel? coinModel;
  const CoinsListTile({Key? key, this.coinModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('hh:mm dd/MM/yyyy')
        .format(DateTime.tryParse(coinModel!.last_updated!)!.toLocal());
    String coinPrice = NumberFormat.currency(name: "")
        .format(coinModel!.market_data!.current_price!["usd"]);

    if (coinModel == null) {
      return Container();
    }
    return Container(
      child: ListTile(
        onTap: () {
          var dialog = coinsDetailsDialog(context, coinModel);
          showDialog(context: context, builder: (context) => dialog);
        },
        leading: Image.network(coinModel!.image!.thumb!),
        subtitle: Text(formattedDate),
        title: Text(coinModel!.name!),
        trailing: Text(
          "\$" + coinPrice,
          textScaleFactor: 1.25,
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
