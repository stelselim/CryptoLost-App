import 'package:flutter/material.dart';

void showDeleteDialog({
  required BuildContext context,
  required String title,
  required String content,
  required void Function()? onPressed,
}) {
  final AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text("No"),
      ),
      TextButton(
        onPressed: onPressed,
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
}
