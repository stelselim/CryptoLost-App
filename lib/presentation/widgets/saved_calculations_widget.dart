import 'package:cryptolostapp/application/models/calculations.dart';
import 'package:cryptolostapp/utility/save_calculation.dart';
import 'package:cryptolostapp/utility/share_calculation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class SavedCalculationWidget extends StatelessWidget {
  final Calculation? localcalculation;
  final Function(void Function())? setState;
  final BuildContext? context;
  final int? index;

  const SavedCalculationWidget({
    Key? key,
    this.context,
    this.localcalculation,
    this.setState,
    this.index,
  }) : super(key: key);

  static const trailingTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: Colors.red,
  );

  void delete() async {
    try {
      final snackBar = SnackBar(content: Text('Calculation deleted!'));
      ScaffoldMessenger.of(context!).showSnackBar(snackBar);
      await deleteCalculation(index!);
      setState!(() {});
    } catch (e) {
      print(e);
    }
  }

  void share() async {
    try {
      await shareCalculation(localcalculation!);
    } catch (e) {
      print(e);
    }
  }

  Widget trailingWidget() {
    if (localcalculation!.isLoss) {
      return Text(
        "- %" + localcalculation!.percentage.toStringAsFixed(2),
        style: trailingTextStyle,
      );
    } else {
      return Text(
        "%" + localcalculation!.percentage.toStringAsFixed(2),
        style: trailingTextStyle.copyWith(color: Colors.green),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var coin = localcalculation!.coinModel;
    var datetime = localcalculation!.dateTime;
    var ratio = localcalculation!.percentage;

    var currentprice = Text(
      coin.market_data!.current_price!["usd"]!.toStringAsFixed(2),
    );
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        child: ListTile(
          leading: Image.network(coin.image!.thumb!),
          subtitle:
              Text("Today - " + DateFormat('MM-dd-yyyy').format(datetime)),
          title: Text(coin.name!),
          trailing: trailingWidget(),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () => share(),
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => delete(),
        ),
      ],
    );
  }
}
