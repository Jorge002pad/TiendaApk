import 'package:flutter/material.dart';
import '../models/product.dart';

class AddPage extends StatefulWidget {
  final Function(Product) onProductAdded;

  const AddPage({super.key, required this.onProductAdded});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKeyProduct = GlobalKey<FormState>();
  final _formKeyUser = GlobalKey<FormState>();

  String _productName = '';
  double _productPrice = 0;
  bool _isFavorite = false;

  String _username = '';
  String _email = '';

  void _submitProductForm() {
    if (_formKeyProduct.currentState!.validate()) {
      _formKeyProduct.currentState!.save();

      Product newProduct = Product(
        name: _productName,
        price: _productPrice,
        isFavorite: _isFavorite,
        imagePath: 'assets/images/product.png', // Imagen por defecto
      );

      widget.onProductAdded(newProduct);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto agregado')),
      );

      _formKeyProduct.currentState!.reset();
      setState(() => _isFavorite = false);
    }
  }

  void _submitUserForm() {
    if (_formKeyUser.currentState!.validate()) {
      _formKeyUser.currentState!.save();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario $_username registrado (simulado)')),
      );

      _formKeyUser.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Agregar Producto', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Form(
            key: _formKeyProduct,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nombre del producto'),
                  validator: (value) => value!.isEmpty ? 'Ingresa un nombre' : null,
                  onSaved: (value) => _productName = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Precio'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Ingresa un precio';
                    if (double.tryParse(value) == null) return 'Debe ser un número';
                    return null;
                  },
                  onSaved: (value) => _productPrice = double.parse(value!),
                ),
                CheckboxListTile(
                  value: _isFavorite,
                  title: const Text('Marcar como favorito'),
                  onChanged: (value) {
                    setState(() => _isFavorite = value!);
                  },
                ),
                ElevatedButton(
                  onPressed: _submitProductForm,
                  child: const Text('Agregar producto'),
                ),
              ],
            ),
          ),
          const Divider(height: 40),
          const Text('Registrar Usuario (Simulado)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Form(
            key: _formKeyUser,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nombre de usuario'),
                  validator: (value) => value!.isEmpty ? 'Ingresa un nombre' : null,
                  onSaved: (value) => _username = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Correo electrónico'),
                  validator: (value) => value!.contains('@') ? null : 'Ingresa un correo válido',
                  onSaved: (value) => _email = value!,
                ),
                ElevatedButton(
                  onPressed: _submitUserForm,
                  child: const Text('Registrar usuario'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
