import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mi_proyecto/services/models/product.dart';

class FirebaseServices {
  final CollectionReference _productosCollection =
      FirebaseFirestore.instance.collection('productos');

  // Método para agregar un nuevo producto
  Future<void> agregarProducto(Product producto) async {
    try {
      await _productosCollection.add({
        'fecha': producto.date,
        'nombre': producto.name,
        'tipo': producto.type,
        'sku': producto.sku,
        'stock': producto.stock,
        'precio': producto.price,
        'imagen': producto.imagePath,
      });
    } catch (e) {
      throw Exception('Error al agregar el producto: $e');
    }
  }

  // Método para obtener todos los productos
  Future<List<Product>> obtenerProductos() async {
    try {
      QuerySnapshot snapshot = await _productosCollection.get();
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Product(
          data['fecha'],
          data['nombre'],
          data['tipo'],
          data['sku'],
          data['stock'],
          data['precio'],
          imagePath: data['imagen'],
          id: null,
        );
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener los productos: $e');
    }
  }

  // Método para actualizar un producto
  Future<void> actualizarProducto(String id, Product producto) async {
    try {
      await _productosCollection.doc(id).update({
        'fecha': producto.date,
        'nombre': producto.name,
        'tipo': producto.type,
        'sku': producto.sku,
        'stock': producto.stock,
        'precio': producto.price,
        'imagen': producto.imagePath,
      });
    } catch (e) {
      throw Exception('Error al actualizar el producto: $e');
    }
  }

  // Método para eliminar un producto
  Future<void> eliminarProducto(String id) async {
    try {
      await _productosCollection.doc(id).delete();
    } catch (e) {
      throw Exception('Error al eliminar el producto: $e');
    }
  }
}
