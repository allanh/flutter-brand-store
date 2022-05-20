import '../app/utils/constants.dart';

extension IntExtension on int {
  /// convert a string with the dollar sign
  String toDollarString() => '\$ ${numberFormat.format(this)}';
}
