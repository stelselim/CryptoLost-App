import 'package:cryptolostapp/application/models/coin.dart';
import 'package:cryptolostapp/infrastructure/coins.dart';
import 'package:cryptolostapp/presentation/widgets/coins_dropdown_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CoinModel? dropdownValue;
  final CoinDataRepository coinDataRepository = CoinDataRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: StreamBuilder<List<CoinModel>>(
          stream: coinDataRepository.getCoins().asStream(),
          builder: (context, snapshot) {
            if (snapshot.data == null) return CircularProgressIndicator();
            if (!snapshot.hasData) return Container();

            return Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: DropdownButton<CoinModel>(
                            hint: Text("Select"),
                            onChanged: (val) {
                              print(val);
                              setState(() {
                                dropdownValue = val;
                              });
                            },
                            value: dropdownValue,
                            items: snapshot.data
                                ?.map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.symbol,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: TextField(),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    color: Colors.red,
                  ),
                )
              ],
            );
          }),
    );
  }
}
