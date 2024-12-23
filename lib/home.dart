import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mi_proyecto/proveedor.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  // Método para obtener productos desde Firestore
  Future<List<Map<String, dynamic>>> _getProducts() async {
    // Obtener productos desde la colección 'productos' en Firestore
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('productos').get();
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nombre PYME'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/carrito');
            },
            child: Text('Carrito'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/admin');
            },
            child: Text('Panel administrador'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Catálogo ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount;

                  if (screenWidth < 600) {
                    crossAxisCount = 2;
                  } else if (screenWidth < 900) {
                    crossAxisCount = 3;
                  } else {
                    crossAxisCount = 4;
                  }

                  return FutureBuilder<List<Map<String, dynamic>>>(
                    future: _getProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                            child: Text('No hay productos disponibles.'));
                      }

                      List<Map<String, dynamic>> products = snapshot.data!;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          Map<String, dynamic> product = products[index];
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    height: 100,
                                    color: Colors.grey[300],
                                    child: product['imagen'] != null
                                        ? Image.network(
                                            product['imagen'],
                                            fit: BoxFit.cover,
                                          )
                                        : const Icon(Icons.image),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  product['nombre'] ?? 'Producto ${index + 1}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product['descripcion'] ?? 'Breve descripción',
                                  style: const TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '\$${product['precio'] ?? 0.0}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),

                                // Botón para añadir al carrito
                                ElevatedButton(
                                  onPressed: () {
                                    _addToCart(product, context);
                                  },
                                  child: const Text("Añadir al carrito"),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addToCart(Map<String, dynamic> product, BuildContext context) {
    // Usamos el CartProvider para añadir el producto
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.addProduct(product); // Añadir el producto al carrito

    // Mostrar un SnackBar para confirmar que el producto fue añadido
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product['nombre']} añadido al carrito')),
    );
  }
}
