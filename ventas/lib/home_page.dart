import 'package:flutter/material.dart';
import 'pages/catalog_page.dart';
import 'pages/favorites_page.dart';
import 'pages/cart_page.dart';
import 'models/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Product> _allProducts = [
    Product(name: 'Camiseta', price: 20.0, image: 'assets/images/product.png'),
    Product(name: 'Pantalón', price: 35.0, image: 'assets/images/product.png'),
    Product(name: 'Zapatos', price: 50.0, image: 'assets/images/product.png'),
  ];

  final List<Product> _favorites = [];
  final List<Product> _cart = [];

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      CatalogPage(
        products: _allProducts,
        onFavoriteToggle: _toggleFavorite,
        onAddToCart: _addToCart,
        favorites: _favorites,
      ),
      FavoritesPage(
        favorites: _favorites,
        onFavoriteToggle: _toggleFavorite,
        onAddToCart: _addToCart,
      ),
      CartPage(
        cart: _cart,
        onRemoveFromCart: _removeFromCart,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda Genérica'),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Catálogo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
        ],
      ),
    );
  }

  void _toggleFavorite(Product product) {
    setState(() {
      if (_favorites.contains(product)) {
        _favorites.remove(product);
      } else {
        _favorites.add(product);
      }
    });
  }
  void _addToCart(Product product) {
    setState(() {
      _cart.add(product);
    });
  }

  void _removeFromCart(Product product) {
    setState(() {
      _cart.remove(product);
    });
  }
}

