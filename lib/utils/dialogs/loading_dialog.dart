import 'package:flutter/material.dart';

typedef CloseDiaglog = void Function();

CloseDiaglog showLoadingDialog({
  required BuildContext context,
  required String text,
}) {
  final dialog = AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 10),
        Text(text),
      ],
    ),
  );

  showDialog(
    context: context,
    barrierDismissible: false, // user tapping outside doesnt dismiss the dialog
    builder: (context) => dialog,
  );

// return the created function when the user calls this function
  return () {
    Navigator.of(context).pop();
  };
}
