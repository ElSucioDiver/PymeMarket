import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];

  // Método para añadir un producto al carrito
  void addProduct(Map<String, dynamic> product) {
    _cartItems.add(product);
    notifyListeners(); // Notificar a los listeners
  }

  // Método para obtener los productos en el carrito
  List<Map<String, dynamic>> get cartItems => _cartItems;

  // Método para obtener el total de productos en el carrito
  int get totalItems => _cartItems.length;
}
