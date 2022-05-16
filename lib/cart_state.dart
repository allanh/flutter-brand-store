import 'package:flutter/foundation.dart';

/// 購物車狀態
class CartState extends ChangeNotifier {
  final cartItems = <String>[];

  void addItem(String item) {
    cartItems.add(item);
    notifyListeners();
  }

  void removeItem(String item) {
    cartItems.add(item);
    notifyListeners();
  }

  void clear() {
    cartItems.clear();
    notifyListeners();
  }
}
