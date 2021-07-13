import "package:flutter/material.dart";

Future<DateTime?> pickDate(BuildContext context) async {
  final res = await showDatePicker(
    context: context,
    initialDate: DateTime.now().subtract(const Duration(days: 1)),
    firstDate: DateTime(2015),
    lastDate: DateTime.now().subtract(const Duration(days: 1)),
  );
  return res;
}
