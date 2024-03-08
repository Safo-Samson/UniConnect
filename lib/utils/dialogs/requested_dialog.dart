import 'package:flutter/material.dart';
import 'package:uniconnect/utils/dialogs/generic_dialog.dart';

Future<void> showRequestSentDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: 'Connection Request Sent!',
    message: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
