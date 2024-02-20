import 'package:flutter/material.dart';
import 'package:uniconnect/utils/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: 'An error occured',
    message: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
