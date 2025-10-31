class Product {
  final String name;
  final double price;
  final String image;
  final String category;
  final int cartQt;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    this.cartQt = 1, // default quantity
  });

  // Factory constructor to create Product from JSON map
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String,
      price: _parsePrice(json['price']),
      image: json['image'] as String,
      category: json['category'] as String,
      cartQt: (json['cartqt'] is int && json['cartqt']! > 0)
          ? json['cartqt']
          : 1, // ✅ fallback to 1
    );
  }

  static double _parsePrice(dynamic price) {
    if (price is double) return price;
    if (price is int) return price.toDouble();
    if (price is String) {
      return double.tryParse(price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
    }
    return 0.0;
  }

  // Convert Product to JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'image': image,
      'category': category,
      'cartqt': cartQt,
    };
  }

  // CopyWith method to update fields
  Product copyWith({
    String? name,
    double? price,
    String? image,
    String? category,
    int? cartQt,
  }) {
    return Product(
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      category: category ?? this.category,
      cartQt: cartQt ?? this.cartQt,
    );
  }
}
