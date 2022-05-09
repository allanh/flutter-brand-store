import 'package:flutter/material.dart';
import '../../domain/entities/sort_option.dart';

class JsonValueConverter {
  // int <==> bool
  static bool boolFromInt(int value) => value == 1;
  static int boolToInt(bool success) => success ? 1 : 0;
  // string <==> bool
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
  // hex string <==> color
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
  // string <==> SortOptions
  static SortOptions sortOptionsFromString(String done) {
    SortOptions option = SortOptions.priceAscending;
    if (done == 'price_asc' || done == 'PRICE_ASC') {
      option = SortOptions.priceAscending;
    } else if (done == 'price_desc' || done == 'PRICE_DESC') {
      option = SortOptions.priceDescending;
    } else if (done == 'new' || done == 'NEW') {
      option = SortOptions.newArrival;
    } else if (done == 'hot' || done == 'HOT') {
      option = SortOptions.hot;
    }
    return option;
  }
  static String sortOptionToString(SortOptions done)  {
    String result = 'price_asc';
    switch (done) {
      case SortOptions.priceAscending:
        result = 'price_asc';
        break;
      case SortOptions.priceDescending:
        result = 'price_desc';
        break;
      case SortOptions.newArrival:
        result = 'new';
        break;
      case SortOptions.hot:
        result = 'hot';
        break;
    }
    return result;
  }
  // string <==> int
  static int intFromString(String? string) {
    if (string != null) {
      return int.parse(string);
    }
    return 0;
  } 
  static String intToString(int? value) {
    if (value != null) {
      return value.toString();
    }
    return '';
  }
}