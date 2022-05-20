import 'package:intl/intl.dart';

import '../app/utils/constants.dart';

extension IntExtension on int {
  /// convert a string with the dollar sign
  String toDollarString() {
    var number = '\$ ${numberFormat.format(this)}';
    return number.contains('.') ? number.split('.').first : number;
  }
}
