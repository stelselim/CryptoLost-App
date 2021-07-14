import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class ProgressModel {
  final String id; // Genetared by function.
  final String name; // User Input

  final num initialMoney; // User Input
  final String currency; // User Input
  final int percentage; // User Input
  final int durationInWeeks; // User Input

  final num goalMoney; // Genetared by function.
  final List<num> steps; // Genetared by function.

  final int currentStepIndex; // According To User Update
  final List<ProgressJourneyStops> journeyDates; // According To User Update

  final DateTime lastUpdated; // According To User Update
  final DateTime createdDate; // According To User Update
  const ProgressModel({
    required this.id,
    required this.name,
    required this.initialMoney,
    required this.currency,
    required this.percentage,
    required this.durationInWeeks,
    required this.goalMoney,
    required this.steps,
    required this.currentStepIndex,
    required this.journeyDates,
    required this.lastUpdated,
    required this.createdDate,
  });

  ProgressModel copyWith({
    String? id,
    String? name,
    num? initialMoney,
    String? currency,
    int? percentage,
    int? durationInWeeks,
    num? goalMoney,
    List<num>? steps,
    int? currentStepIndex,
    List<ProgressJourneyStops>? journeyDates,
    DateTime? lastUpdated,
    DateTime? createdDate,
  }) {
    return ProgressModel(
      id: id ?? this.id,
      name: name ?? this.name,
      initialMoney: initialMoney ?? this.initialMoney,
      currency: currency ?? this.currency,
      percentage: percentage ?? this.percentage,
      durationInWeeks: durationInWeeks ?? this.durationInWeeks,
      goalMoney: goalMoney ?? this.goalMoney,
      steps: steps ?? this.steps,
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      journeyDates: journeyDates ?? this.journeyDates,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'initialMoney': initialMoney,
      'currency': currency,
      'percentage': percentage,
      'durationInWeeks': durationInWeeks,
      'goalMoney': goalMoney,
      'steps': steps,
      'currentStepIndex': currentStepIndex,
      'journeyDates': journeyDates.map((x) => x.toMap()).toList(),
      'lastUpdated': lastUpdated.millisecondsSinceEpoch,
      'createdDate': createdDate.millisecondsSinceEpoch,
    };
  }

  factory ProgressModel.fromMap(Map<String, dynamic> map) {
    return ProgressModel(
      id: map['id'],
      name: map['name'],
      initialMoney: map['initialMoney'],
      currency: map['currency'],
      percentage: map['percentage'],
      durationInWeeks: map['durationInWeeks'],
      goalMoney: map['goalMoney'],
      steps: List<num>.from(map['steps']),
      currentStepIndex: map['currentStepIndex'],
      journeyDates: List<ProgressJourneyStops>.from(
          map['journeyDates']?.map((x) => ProgressJourneyStops.fromMap(x))),
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(map['lastUpdated']),
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProgressModel.fromJson(String source) =>
      ProgressModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProgressModel(id: $id, name: $name, initialMoney: $initialMoney, currency: $currency, percentage: $percentage, durationInWeeks: $durationInWeeks, goalMoney: $goalMoney, steps: $steps, currentStepIndex: $currentStepIndex, journeyDates: $journeyDates, lastUpdated: $lastUpdated, createdDate: $createdDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProgressModel &&
        other.id == id &&
        other.name == name &&
        other.initialMoney == initialMoney &&
        other.currency == currency &&
        other.percentage == percentage &&
        other.durationInWeeks == durationInWeeks &&
        other.goalMoney == goalMoney &&
        listEquals(other.steps, steps) &&
        other.currentStepIndex == currentStepIndex &&
        listEquals(other.journeyDates, journeyDates) &&
        other.lastUpdated == lastUpdated &&
        other.createdDate == createdDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        initialMoney.hashCode ^
        currency.hashCode ^
        percentage.hashCode ^
        durationInWeeks.hashCode ^
        goalMoney.hashCode ^
        steps.hashCode ^
        currentStepIndex.hashCode ^
        journeyDates.hashCode ^
        lastUpdated.hashCode ^
        createdDate.hashCode;
  }
}

@immutable
class ProgressJourneyStops {
  final DateTime dateTime;
  final int stepIndex;
  final num money;
  const ProgressJourneyStops({
    required this.dateTime,
    required this.stepIndex,
    required this.money,
  });

  ProgressJourneyStops copyWith({
    DateTime? dateTime,
    int? stepIndex,
    num? money,
  }) {
    return ProgressJourneyStops(
      dateTime: dateTime ?? this.dateTime,
      stepIndex: stepIndex ?? this.stepIndex,
      money: money ?? this.money,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime.millisecondsSinceEpoch,
      'stepIndex': stepIndex,
      'money': money,
    };
  }

  factory ProgressJourneyStops.fromMap(Map<String, dynamic> map) {
    return ProgressJourneyStops(
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      stepIndex: map['stepIndex'],
      money: map['money'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProgressJourneyStops.fromJson(String source) =>
      ProgressJourneyStops.fromMap(json.decode(source));

  @override
  String toString() =>
      'ProgressJourneyStops(dateTime: $dateTime, stepIndex: $stepIndex, money: $money)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProgressJourneyStops &&
        other.dateTime == dateTime &&
        other.stepIndex == stepIndex &&
        other.money == money;
  }

  @override
  int get hashCode => dateTime.hashCode ^ stepIndex.hashCode ^ money.hashCode;
}
