class ProductUiModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;

  ProductUiModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
}

List<ProductUiModel> dummyProducts = [
  ProductUiModel(
    id: '1',
    name: 'Apple',
    description: 'Fresh red apples from the farm.',
    price: 1.99,
    imageUrl: 'https://via.placeholder.com/150',
    category: 'Fruits',
  ),
  ProductUiModel(
    id: '2',
    name: 'Banana',
    description: 'Ripe yellow bananas, perfect for snacking.',
    price: 0.99,
    imageUrl: 'https://via.placeholder.com/150',
    category: 'Fruits',
  ),
  ProductUiModel(
    id: '3',
    name: 'Milk',
    description: 'Organic whole milk from grass-fed cows.',
    price: 3.49,
    imageUrl: 'https://via.placeholder.com/150',
    category: 'Dairy',
  ),
  ProductUiModel(
    id: '4',
    name: 'Bread',
    description: 'Freshly baked whole grain bread.',
    price: 2.49,
    imageUrl: 'https://via.placeholder.com/150',
    category: 'Bakery',
  ),
];
