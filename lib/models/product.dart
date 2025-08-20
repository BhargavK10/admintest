class Product{
  final String id;
  final String name;
  final String description;
  final double price;
  final List<String> images;
  final Map<String, dynamic> technicalInfo;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.technicalInfo
  });

  // Factory constructor to parse from Supabase JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      images: List<String>.from(json['image_urls'] ?? []),
      technicalInfo: json['technical_info'] ?? {},
    );
  }
}