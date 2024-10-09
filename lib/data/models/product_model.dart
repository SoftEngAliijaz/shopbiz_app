class ProductModel {
  final String id;
  final String name;
  final String description;
  final int quantity;
  final String brand;
  final String condition;
  final String category;
  final bool isOnSale;
  final bool isDiscountAvailable;
  final double price;

  ProductModel({
    required this.id,
    required this.name,
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
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
