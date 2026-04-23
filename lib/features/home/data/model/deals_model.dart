class DealModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final double finalPrice;
  final bool hasOffer;
  final String? offerTitle;

  DealModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.finalPrice,
    required this.hasOffer,
    this.offerTitle,
  });

  factory DealModel.fromJson(Map<String, dynamic> json) {
    return DealModel(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      finalPrice: (json['final_price'] ?? 0).toDouble(),
      hasOffer: json['has_offer'] ?? false,
      offerTitle: json['offer_title'],
    );
  }
}