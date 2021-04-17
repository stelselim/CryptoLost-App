import 'package:cryptolostapp/application/models/calculations.dart';
import 'package:cryptolostapp/presentation/widgets/saved_calculations_widget.dart';
import 'package:cryptolostapp/utility/save_calculation.dart';
import 'package:flutter/material.dart';

class SavedCalculationsScreen extends StatelessWidget {
  const SavedCalculationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StatefulBuilder(
        builder: (context, setStateFromBuilder) =>
            FutureBuilder<List<Calculation>>(
                future: getCalculations(),
                builder: (context, snapshot) {
                  if (snapshot.data == null)
                    return Center(child: Text("There is No Saved Data"));

                  if (snapshot.hasError)
                    return Center(child: Text("An Error Occured"));

                  if (snapshot.data!.length == 0)
                    return Center(child: Text("There is No Saved Data"));

                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return SavedCalculationWidget(
                        context: context,
                        index: index,
                        setState: setStateFromBuilder,
                        localcalculation: snapshot.data!.elementAt(index),
                      );
                    },
                  );
                }),
      ),
    );
  }
}
