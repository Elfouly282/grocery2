class MealRecommendationModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String? offerTitle;
  final double price;
  final double finalPrice;
  final bool hasOffer;
  final String categoryName;

  MealRecommendationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.offerTitle,
    required this.price,
    required this.finalPrice,
    required this.hasOffer,
    required this.categoryName,
  });

  factory MealRecommendationModel.fromJson(Map<String, dynamic> json) {
    return MealRecommendationModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
      offerTitle: json['offer_title'],
      price: (json['price'] as num).toDouble(),
      finalPrice: (json['final_price'] as num).toDouble(),
      hasOffer: json['has_offer'] ?? false,
      categoryName: json['category']['name'],
    );
  }
}