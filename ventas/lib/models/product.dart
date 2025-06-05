class Product {
  final String name;
  final double price;
  final bool isFavorite;
  final String imagePath;

  Product({
    required this.name,
    required this.price,
    required this.isFavorite,
    required this.imagePath,
  });

  // Para poder comparar productos por su nombre
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
