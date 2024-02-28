import 'package:flutter/material.dart';
import 'package:uniconnect/utils/dialogs/generic_dialog.dart';

Future<void> showNothingDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: 'Feature not available yet',
    message: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
