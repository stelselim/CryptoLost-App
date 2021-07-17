import 'package:cryptolostapp/application/models/progress_model.dart';
import 'package:cryptolostapp/application/provider/appstate.dart';
import 'package:cryptolostapp/infrastructure/progress/progress_repository.dart';
import 'package:cryptolostapp/presentation/widgets/dialog/delete_dialog.dart';
import 'package:cryptolostapp/utility/analytics/google_anayltics_functions.dart';
import 'package:cryptolostapp/utility/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProgressDetailScreen extends StatefulWidget {
  final String progressModelId;
  const ProgressDetailScreen({
    Key? key,
    required this.progressModelId,
  }) : super(key: key);

  @override
  _ProgressDetailScreenState createState() => _ProgressDetailScreenState();
}

class _ProgressDetailScreenState extends State<ProgressDetailScreen> {
  final ProgressRepository progressRepository = ProgressRepository();

  Future<void> onDelete() async {
    try {
      await progressRepository.deleteProgress(widget.progressModelId);
      Fluttertoast.showToast(msg: "Deleted!");
      Navigator.pushNamed(context, homeRoute);
      Provider.of<AppState>(context, listen: false).updateIndex(2);
    } catch (e) {
      print(e);
    }
  }

  List<ProgressJourneyStops> updateToProgressJourney({
    required int index,
    required ProgressModel progressModel,
  }) {
    final journey = progressModel.journeyDates;
    journey.add(ProgressJourneyStops(
      dateTime: DateTime.now(),
      stepIndex: index,
      money: progressModel.steps[index],
    ));
    return journey;
  }

  Future<void> onUpdate({
    required bool? value,
    required int index,
    required ProgressModel progressModel,
  }) async {
    try {
      updateProgressEvent();

      if (value != null && value) {
        await progressRepository.updateProgress(progressModel.copyWith(
          currentStepIndex: index,
          journeyDates: updateToProgressJourney(
              index: index, progressModel: progressModel),
        ));
        setState(() {});
      } else {
        if (index == 0) return;
        await progressRepository.updateProgress(progressModel.copyWith(
          currentStepIndex: index - 1,
          journeyDates: updateToProgressJourney(
              index: index, progressModel: progressModel),
        ));
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> nameUpdate({
    required String name,
    required String progressModelId,
  }) async {
    if (name != "") {
      final progressModel =
          await progressRepository.getProgress(progressModelId);
      await progressRepository.updateProgress(progressModel.copyWith(
        name: name,
      ));
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Name updated!");
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    progressDetailedPScreenEvent();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.progressModelId == "") {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text("A Problem Occured!"),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Stairs to Goal!"),
        actions: [
          IconButton(
            onPressed: () {
              final textController = TextEditingController();
              final AlertDialog alert = AlertDialog(
                title: const Text("New Name"),
                content: SizedBox(
                  height: 120,
                  child: Column(
                    children: [
                      const Text("Type a new name for this Money Ladder!"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: textController,
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("No"),
                  ),
                  TextButton(
                    onPressed: () => nameUpdate(
                      name: textController.text,
                      progressModelId: widget.progressModelId,
                    ),
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
            icon: const Icon(
              Icons.edit_outlined,
            ),
          ),
          IconButton(
            onPressed: () => showDeleteDialog(
              context: context,
              title: "Delete Money Ladder",
              content: "This operation removes progress permanently",
              onPressed: () => onDelete(),
            ),
            icon: const Icon(
              Icons.delete_forever_outlined,
            ),
          )
        ],
      ),
      body: StreamBuilder<ProgressModel>(
          stream:
              progressRepository.getProgress(widget.progressModelId).asStream(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text("An Error Occured"));
            }

            final progressModel = snapshot.data;

            return Center(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                itemCount: progressModel!.steps.length,
                itemBuilder: (context, index) {
                  final currentIndex = progressModel.currentStepIndex;
                  const lineThroughStyle = TextStyle(
                    decorationThickness: 2.0,
                    decorationStyle: TextDecorationStyle.solid,
                    decoration: TextDecoration.lineThrough,
                  );
                  return ListTile(
                    leading: Text(
                      "Day ${(index + 1).toString()}",
                      style: currentIndex >= index ? lineThroughStyle : null,
                    ),
                    trailing: Checkbox(
                      onChanged: (bool? value) => onUpdate(
                        index: index,
                        progressModel: progressModel,
                        value: value,
                      ),
                      value: currentIndex >= index,
                    ),
                    title: Text(
                      "Reach ${progressModel.steps[index].toString()}  ${progressModel.currency.toString()}",
                      textAlign: TextAlign.center,
                      style: currentIndex >= index ? lineThroughStyle : null,
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
