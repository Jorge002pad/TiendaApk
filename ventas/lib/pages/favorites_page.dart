import 'package:flutter/material.dart';
import '../models/product.dart';

class FavoritesPage extends StatelessWidget {
  final List<Product> favorites;
  final Function(Product) onFavoriteToggle;
  final Function(Product) onAddToCart;

  const FavoritesPage({
    super.key,
    required this.favorites,
    required this.onFavoriteToggle,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return const Center(
        child: Text(
          'No tienes productos favoritos aún.',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final product = favorites[index];

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
                  icon: const Icon(Icons.remove_circle),
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
