import '../app/utils/constants.dart';

extension NumExtension on num {
  /// convert a string with the dollar sign
  String toDollarString() => '\$ ${numberFormat.format(this)}';
}
