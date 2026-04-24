class Meal {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final double finalPrice;

  Meal({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.finalPrice,
  });
  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      imageUrl: json['image_url'] ?? '',
      price: (json['price'] is num) ? (json['price'] as num).toDouble() : 0.0,
      finalPrice: (json['final_price'] is num)
          ? (json['final_price'] as num).toDouble()
          : 0.0,
    );
  }
}
