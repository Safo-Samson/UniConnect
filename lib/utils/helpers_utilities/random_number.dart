import 'dart:math';

  // Function to generate a random number between 10 and 99
int generateRandomNumber() {
  final random = Random();
  return random.nextInt(90) + 10;
}
