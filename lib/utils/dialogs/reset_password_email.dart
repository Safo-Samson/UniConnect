import 'package:flutter/material.dart';
import 'package:uniconnect/utils/dialogs/generic_dialog.dart';

Future<void> showPasssResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Password Reset',
    message: 'Please check your email to reset your password.',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
