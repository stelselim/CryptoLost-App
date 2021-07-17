import 'package:cryptolostapp/application/models/progress_model.dart';
import 'package:cryptolostapp/application/provider/appstate.dart';
import 'package:cryptolostapp/infrastructure/progress/progress_repository.dart';
import 'package:cryptolostapp/presentation/styles/text_styles.dart';
import 'package:cryptolostapp/presentation/widgets/progress/progress_create_form.dart';
import 'package:cryptolostapp/presentation/widgets/progress/progress_list_tile.dart';
import 'package:cryptolostapp/utility/screensizes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({Key? key}) : super(key: key);
  static ProgressRepository progressRepository = ProgressRepository();

  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  Future<void> onCreate(ProgressModel model) async {
    try {
      await ProgressScreen.progressRepository.createProgress(model);
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  void listenPageOpen() {
    Provider.of<AppState>(context, listen: false).addListener(() {
      final index = Provider.of<AppState>(context, listen: false).index;
      if (index == 2) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    listenPageOpen(); // Every Time Page Opens
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProgressModel>>(
      stream: ProgressScreen.progressRepository.getProgressList().asStream(),
      builder: (context, snapshot) {
        // Loading progress...
        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        // No Data
        if (snapshot.data!.isEmpty) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: getSize(context).height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Create a Money Ladder!",
                    style: headertextStyle,
                    textScaleFactor: 1.55,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: getSize(context).height * 0.01,
                ),
                Center(
                  child: ProgressCreateForm(onCreate: onCreate),
                ),
              ],
            ),
          );
        }
        // Has Error
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: Text("An Error Occured")),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Text("Refresh"),
                ),
              ],
            ),
          );
        }

        // Progresses
        return Column(
          children: [
            Expanded(
              flex: 7,
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 200));
                  setState(() {});
                },
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Create New
                        ElevatedButton(
                          style: const ButtonStyle().copyWith(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                          ),
                          onPressed: () async {
                            final progressCreateDialog = Dialog(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                height: getSize(context).height * 0.55,
                                child: SingleChildScrollView(
                                  physics: const ClampingScrollPhysics(),
                                  child: ProgressCreateForm(
                                    onCreate: (model) {
                                      onCreate(model);
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(
                                        msg: "New Money Ladder Created!",
                                        gravity: ToastGravity.CENTER,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return progressCreateDialog;
                              },
                            );
                          },
                          child: const Text("Create New"),
                        ),
                        // Delete New
                        ElevatedButton(
                          style: const ButtonStyle().copyWith(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.redAccent),
                          ),
                          onPressed: () async {
                            final AlertDialog alert = AlertDialog(
                              title: const Text("Delete All Money Ladders"),
                              content:
                                  const Text("Ladders can not be recovered."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("No"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    try {
                                      await ProgressScreen.progressRepository
                                          .deleteAllProgress();
                                      Navigator.pop(context);
                                      setState(() {});
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  child: const Text("Yes"),
                                ),
                              ],
                            );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          },
                          child: const Text("Delete All"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final element = snapshot.data!.elementAt(index);
                          return ProgressListTile(progressModel: element);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
