import 'package:flutter/material.dart';

import '../class/cartitem.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(String id, String ten, double gia) {
    for (var item in _cartItems) {
      if (item.id == id) {
        item.soLuong++;
        notifyListeners();
        return;
      }
    }

    _cartItems.add(CartItem(id, ten, gia, 1));
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    _cartItems.remove(cartItem);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
