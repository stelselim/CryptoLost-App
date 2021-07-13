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
    fontSize: 18,
    color: Colors.red,
  );

  Future<void> delete() async {
    try {
      const snackBar = SnackBar(content: Text('Calculation deleted!'));
      ScaffoldMessenger.of(context!).showSnackBar(snackBar);
      await deleteCalculation(index!);
      setState!(() {});
    } catch (e) {
      print(e);
    }
  }

  Future<void> share() async {
    try {
      await shareCalculation(localcalculation!);
    } catch (e) {
      print(e);
    }
  }

  Widget trailingWidget() {
    final String profit =
        NumberFormat.currency(name: "").format(localcalculation!.profit);
    if (localcalculation!.isLoss) {
      return Text(
        "\$$profit" + " - %" + localcalculation!.percentage.toStringAsFixed(2),
        style: trailingTextStyle,
      );
    } else {
      return Text(
        "\$$profit" + " %" + localcalculation!.percentage.toStringAsFixed(2),
        style: trailingTextStyle.copyWith(color: Colors.green),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final coin = localcalculation!.coinModel;
    final currentDate = localcalculation!.currentDateTime;

    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      // ignore: sort_child_properties_last
      child: ListTile(
        leading: Image.network(coin.image!.thumb!),
        title: Text(coin.name!),
        subtitle: Text(
          "From ${DateFormat('MM-dd-yyyy').format(currentDate)} To ${DateFormat('MM-dd-yyyy').format(currentDate)}",
        ),
        trailing: trailingWidget(),
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
