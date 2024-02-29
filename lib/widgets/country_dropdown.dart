import 'package:flutter/material.dart';
import 'package:uniconnect/constants/countries_with_flag.dart';

class CountryDropdown extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?) onChanged;

  const CountryDropdown({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      decoration: const InputDecoration(
        hintText: 'Select a Country',
        border: OutlineInputBorder(),
        labelText: 'Select a Country',
      ),
      items: allCountriesWithFlags.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
