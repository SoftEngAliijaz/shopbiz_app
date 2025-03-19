class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.quantity,
    required this.brand,
    required this.condition,
    required this.category,
    required this.isOnSale,
    required this.isDiscountAvailable,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      quantity: json['quantity'],
      brand: json['brand'],
      condition: json['condition'],
      category: json['category'],
      isOnSale: json['isOnSale'],
      isDiscountAvailable: json['isDiscountAvailable'],
      price: json['price'],
    );
  }

  final String brand;
  final String category;
  final String condition;
  final String description;
  final String id;
  final String imageUrl;
  final bool isDiscountAvailable;
  final bool isOnSale;
  final String name;
  final double price;
  final int quantity;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'quantity': quantity,
      'brand': brand,
      'condition': condition,
      'category': category,
      'isOnSale': isOnSale,
      'isDiscountAvailable': isDiscountAvailable,
      'price': price,
    };
  }
}
