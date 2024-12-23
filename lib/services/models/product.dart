// lib/models/product.dart

class Product {
  final DateTime date;
  final String name;
  final String type; // Agregar tipo
  final String sku; // Agregar código SKU
  final int stock; // Agregar stock
  final double price; // Agregar precio
  final String? imagePath; // Agregar imagen

  Product(this.date, this.name, this.type, this.sku, this.stock, this.price,
      {this.imagePath, required id});
}
