import 'dart:math';

String generateRandomUppercaseLetter() {
  final Random random = Random();
  final int charCode =
      random.nextInt(26) + 65; // ASCII code for uppercase letters (65-90)
  return String.fromCharCode(charCode);
}
