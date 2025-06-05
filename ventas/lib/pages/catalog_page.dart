import 'package:flutter/material.dart';
import '../models/product.dart';

class CatalogPage extends StatelessWidget {
  final List<Product> products;
  final Function(Product) onFavoriteToggle;
  final Function(Product) onAddToCart;
  final List<Product> favorites;

  const CatalogPage({
    super.key,
    required this.products,
    required this.onFavoriteToggle,
    required this.onAddToCart,
    required this.favorites,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        // Número de productos
        itemCount: products.length,

        // Cómo se verá cada card
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // ← Número de columnas (cámbialo a 1 o 3 si quieres)
          childAspectRatio: 3 / 4, // ← Proporción ancho/alto (ajústalo libremente)
          crossAxisSpacing: 12, // ← Espacio horizontal entre cards
          mainAxisSpacing: 12, // ← Espacio vertical entre cards
        ),

        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.asset(
                      product.imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          product.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: product.isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () => onFavoriteToggle(product),
                      ),
                      IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        onPressed: () => onAddToCart(product),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
