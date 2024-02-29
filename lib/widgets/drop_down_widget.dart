import 'package:flutter/material.dart';

class DropdownFormField extends StatelessWidget {
  final String label;
  final List<String> items;
  final TextEditingController controller;
  final Function(String?) onChanged;

  const DropdownFormField({
    super.key,
    required this.label,
    required this.items,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: 'Select $label',
        border: const OutlineInputBorder(),
        labelText: label,
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
