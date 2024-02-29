import 'package:flutter/material.dart';

class DateField extends StatelessWidget {
  final TextEditingController controller;
  final Function() onTap;
  final Function() onChanged;

  const DateField({
    super.key,
    required this.controller,
    required this.onTap,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        onChanged();
      },
      readOnly: true,
      controller: controller,
      onTap: onTap,
      decoration: const InputDecoration(
        hintText: '12/07/2002',
        border: OutlineInputBorder(),
        labelText: 'Date of Birth',
      ),
    );
  }
}
