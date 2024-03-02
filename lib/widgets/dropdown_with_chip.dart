import 'package:flutter/material.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';
import 'package:uniconnect/utils/Brand/spaces.dart';

class DropdownWithChip extends StatefulWidget {
  final String label;
  final List<String> selectedValues;
  final List<String> items;
  final Function(String?) onChanged;
  final Function(String?) onItemRemoved; // New callback for item removal

  const DropdownWithChip({
    Key? key,
    required this.label,
    required this.selectedValues,
    required this.items,
    required this.onChanged,
    required this.onItemRemoved, // Pass the callback from the parent widget
  }) : super(key: key);

  @override
  DropdownWithChipState createState() => DropdownWithChipState();
}

class DropdownWithChipState extends State<DropdownWithChip> {
  late List<String> _selectedValues;

  @override
  void initState() {
    _selectedValues = List.from(widget.selectedValues);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: BrandFonts.regularText,
           
          ),
        ),
        verticalSpace(10.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.only(bottom: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Wrap(
            spacing: 8.0,
            children: _selectedValues.isEmpty
                ? [const Chip(label: Text('Any'))]
                : _selectedValues.map((String value) {
                    return Chip(
                      label: Text(value),
                      deleteIcon: const Icon(Icons.close),
                      onDeleted: () {
                        setState(() {
                          _selectedValues.remove(value);
                          widget.onItemRemoved(value); // Call the callback
                        });
                      },
                    );
                  }).toList(),
          ),
        ),
        DropdownButtonFormField<String>(
          isExpanded: true,
          decoration: const InputDecoration(
            hintText: 'Select',
            border: OutlineInputBorder(),
          ),
          items: widget.items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              if (!_selectedValues.contains(value)) {
                _selectedValues.add(value!);
                widget.onChanged(value);
              }
            });
          },
        ),
      ],
    );
  }
}
