import 'package:flutter/material.dart';
import '../models/product.dart';

class CatalogPage extends StatelessWidget {
  final List<Product> products;
  final List<Product> favorites;
  final Function(Product) onFavoriteToggle;
  final Function(Product) onAddToCart;

  const CatalogPage({
    super.key,
    required this.products,
    required this.favorites,
    required this.onFavoriteToggle,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final isFavorite = favorites.contains(product);

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 4,
          child: ListTile(
            leading: Image.asset(
              product.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: Wrap(
              spacing: 12,
              children: [
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () => onFavoriteToggle(product),
                ),
                IconButton(
                  icon: const Icon(Icons.add_shopping_cart),
                  onPressed: () => onAddToCart(product),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
