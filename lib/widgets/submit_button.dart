import 'package:flutter/material.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const SubmitButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Submit',
          style: TextStyle(fontSize: BrandFonts.textButtonSize)),
    );
  }
}
