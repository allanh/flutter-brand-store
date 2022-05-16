extension StringConvert on String {
  /// convert a String to bool
  bool toBool() {
    return toLowerCase() == 'true';
  }

  /// convert a String to int
  int toInt() {
    return int.parse(this);
  }
}
