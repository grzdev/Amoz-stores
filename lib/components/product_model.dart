class Product {
  final int id;
  final String img;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.img,
    required this.name,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      img: json['img'],
      name: json['name'],
      price: json['price'].toDouble(),
    );
  }
}
