import 'package:flutter/material.dart';

class ShoppingCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> cartItems = []; // El carrito empieza vacío

    const int subtotal =
        0; // Establecer subtotal en 0 porque el carrito está vacío
    const int shipping = 9000;
    const int tax = 5000;
    final int total = subtotal + shipping + tax;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tu carrito"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image),
                    ),
                    title: Text(item["name"] as String),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Descripción del producto..."),
                        Row(
                          children: [
                            Text("Qty: ${item["quantity"]}"),
                            TextButton(
                              onPressed: () {},
                              child: const Text("Remove"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Text("\$${(item["price"] as int) / 100}"),
                  );
                },
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Subtotal:"),
                Text("\$${(subtotal / 100).toStringAsFixed(2)}"),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total:"),
                Text("\$${(total / 100).toStringAsFixed(2)}"),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text("Pagar"),
            ),
          ],
        ),
      ),
    );
  }
}
