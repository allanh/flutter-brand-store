extension IterableExtension on Iterable<int?> {
  /// Returns the first element yielding the largest value of the given function
  ///  or null if there are no elements.
  int? get max => isNotEmpty
      ? fold(first,
          (current, next) => current! > (next ?? current) ? current : next)
      : null;

  /// Returns the first element yielding the smallest value of the given
  /// function or null if there are no elements.
  int? get min => isNotEmpty
      ? fold(first,
          (current, next) => current! < (next ?? current) ? current : next)
      : null;
}
