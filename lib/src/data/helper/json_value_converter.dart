import 'package:flutter/material.dart';

class JsonValueConverter {
  static bool boolFromInt(int value) => value == 1;
  static int boolToInt(bool success) => success ? 1 : 0;
  static bool boolFromString(String? string) {
    if (string != null) {
      return string == "YES";
    }
    return false;
  } 
  static String boolToString(bool? success) {
    if (success != null) {
      return success ? "YES" : "NO";
    }
    return "NO";
  }
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
  static String toHex(Color color) {
  return 
    '${color.alpha.toRadixString(16).padLeft(2, '0')}'
    '${color.red.toRadixString(16).padLeft(2, '0')}'
    '${color.green.toRadixString(16).padLeft(2, '0')}'
    '${color.blue.toRadixString(16).padLeft(2, '0')}';
  }

}