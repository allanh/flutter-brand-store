import 'package:intl/intl.dart';

extension StringExtension on String {
  /// convert a String to bool
  bool toBool() {
    return toLowerCase() == 'true';
  }

  /// convert a String to int
  int toInt() {
    return int.parse(this);
  }

  bool isValidMobile() =>
      isNotEmpty && length == 10 && RegExp("^09\\d{8}\$").hasMatch(this);

  bool isValidEmail() =>
      isNotEmpty &&
      RegExp("^[a-zA-Z0-9][\\w.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\\w.-]*[a-zA-Z0-9]\\.[a-zA-Z][a-zA-Z.]*[a-zA-Z]\$")
          .hasMatch(this);

  bool isValidPwd() =>
      isNotEmpty &&
      length >= 6 &&
      RegExp(".*[A-Za-z].*").hasMatch(this) &&
      RegExp(".*\\d.*").hasMatch(this);

  /// 轉換時間格式
  String convertDateFormat(String oldFormat, String newFormat) {
    DateFormat newDateFormat = DateFormat(newFormat);
    DateTime dateTime = DateFormat(oldFormat).parse(this);
    String selectedDate = newDateFormat.format(dateTime);
    return selectedDate;
  }
}
