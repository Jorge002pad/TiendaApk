import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductFormPage extends StatefulWidget {
  final Function(Product) onAddProduct;

  const ProductFormPage({super.key, required this.onAddProduct});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String description = '';
  double price = 0.0;
  String category = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newProduct = Product(
        name: name,
        price: price,
        isFavorite: false,
        imagePath: 'assets/images/producto.png',
      );

      widget.onAddProduct(newProduct);
      Navigator.pop(context); // Cierra el formulario
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Producto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Requerido' : null,
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Requerido' : null,
                onSaved: (value) => description = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Requerido';
                  if (double.tryParse(value) == null) return 'Debe ser número';
                  return null;
                },
                onSaved: (value) => price = double.parse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Categoría'),
                onSaved: (value) => category = value ?? '',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Agregar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
