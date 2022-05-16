extension MapExtension on Map<String, dynamic> {
  Map<String, dynamic> removeNull() =>
      this..removeWhere((String key, dynamic value) => value == null);
}