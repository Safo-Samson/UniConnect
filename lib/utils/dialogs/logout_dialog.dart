import 'package:flutter/material.dart';
import 'package:uniconnect/utils/dialogs/generic_dialog.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      optionsBuilder: () => {
            'No': false,
            'Yes': true,
          }).then(
    (value) => value ?? false, // that is if the user presses outside the dialog
  );
}
