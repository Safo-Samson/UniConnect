int createUniqueID() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}
