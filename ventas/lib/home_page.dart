import 'package:flutter/material.dart';
import 'pages/catalog_page.dart';
import 'pages/favorites_page.dart';
import 'pages/cart_page.dart';
import 'pages/add_page.dart'; // 👈 nueva página
import 'models/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Product> _allProducts = [
    Product(name: 'Camiseta', isFavorite: false, price: 20.0, imagePath: 'assets/images/product.png'),
    Product(name: 'Pantalón', isFavorite: true, price: 35.0, imagePath: 'assets/images/product.png'),
    Product(name: 'Zapatos', isFavorite: false, price: 50.0, imagePath: 'assets/images/product.png'),
  ];

  final List<Product> _favorites = [];
  final List<Product> _cart = [];

  void _addProduct(Product product) {
    setState(() {
      _allProducts.add(product);
    });
  }

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
      AddPage(onProductAdded: _addProduct), // 👈 NUEVA PÁGINA
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
        selectedItemColor: Colors.blue,       // Color del ítem seleccionado
        unselectedItemColor: Colors.grey,     // Color de ítems no seleccionados
        backgroundColor: Colors.white,        // Fondo de la barra
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
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Agregar',
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
