import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EcommerceMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ecommerce'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Pantallas grandes: mostrar tabla completa
            return _buildTableView();
          } else {
            // Pantallas pequeñas: mostrar lista simplificada
            return _buildListView();
          }
        },
      ),
    );
  }

  Widget _buildTableView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('productos').get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final products = snapshot.data!.docs;

            return DataTable(
              columns: const [
                DataColumn(label: Text('Fecha')),
                DataColumn(label: Text('SKU')),
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Stock')),
                DataColumn(label: Text('Precio')),
                DataColumn(label: Text('Tipo')),
                DataColumn(label: Text('Descripción')),
                DataColumn(label: Text('Imagen')),
              ],
              rows: products.map((product) {
                final data = product.data() as Map<String, dynamic>;
                return DataRow(
                  cells: [
                    DataCell(
                        Text(data['fecha'].toDate().toString().split(' ')[0])),
                    DataCell(Text(data['sku'])),
                    DataCell(Text(data['nombre'])),
                    DataCell(Text(data['stock'].toString())),
                    DataCell(Text('\$${data['precio'].toStringAsFixed(2)}')),
                    DataCell(Text(data['tipo'])),
                    DataCell(Text(data['descripcion'] ?? 'Sin descripción')),
                    DataCell(data['imagen'] != null &&
                            data['imagen'].startsWith('http')
                        ? Image.network(data['imagen'],
                            width: 50, height: 50, fit: BoxFit.cover)
                        : Icon(Icons.image_not_supported)),
                  ],
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildListView() {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('productos').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final products = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index].data() as Map<String, dynamic>;
            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fecha: ${product['fecha'].toDate().toString().split(' ')[0]}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('SKU: ${product['sku']}'),
                    Text('Nombre: ${product['nombre']}'),
                    Text('Stock: ${product['stock']}'),
                    Text('Precio: \$${product['precio'].toStringAsFixed(2)}'),
                    Text('Tipo: ${product['tipo']}'),
                    Text(
                        'Descripción: ${product['descripcion'] ?? 'Sin descripción'}'),
                    if (product['imagen'] != null &&
                        product['imagen'].startsWith('http'))
                      Image.network(product['imagen'],
                          width: 100, height: 100, fit: BoxFit.cover)
                    else
                      Icon(Icons.image_not_supported),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
