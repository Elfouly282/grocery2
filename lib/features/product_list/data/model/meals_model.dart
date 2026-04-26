class MealsModel {
  MealsModel({
    required this.mealId,
    required this.mealTitle,
    required this.mealSlug,
    required this.mealDescription,
    required this.mealImage,
    required this.offerTitle,
    required this.price,
    required this.discountPrice,
    required this.finalPrice,
    required this.rating,
    required this.ratingCount,
    required this.hasOffer,
    required this.isFeatured,
    required this.inStock,
    required this.features,
  });

  final String mealId;
  final String mealTitle;
  final String mealSlug;
  final String mealDescription;
  final String? mealImage;
  final String? offerTitle;
  final double price;
  final double? discountPrice;
  final double finalPrice;
  final double rating;
  final int ratingCount;
  final bool hasOffer;
  final bool isFeatured;
  final bool inStock;
  final String features;

  Map<String, dynamic> toJson() {
    return {
      'id': mealId,
      'title': mealTitle,
      'slug': mealSlug,
      'description': mealDescription,
      'image_url': mealImage,
      'offer_title': offerTitle,
      'price': price,
      'discount_price': discountPrice,
      'final_price': finalPrice,
      'rating': rating,
      'rating_count': ratingCount,
      'has_offer': hasOffer,
      'is_featured': isFeatured,
      'in_stock': inStock,
      'features': features,
    };
  }

  factory MealsModel.fromJson(Map<String, dynamic> json) {
    return MealsModel(
      mealId: json['id'].toString(),
      mealTitle: json['title'] as String,
      mealSlug: json['slug'] as String,
      mealDescription: json['description'] as String,
      mealImage: json['image_url'] as String,
      offerTitle: (json['offer_title'] as String?),
      price: (json['price'] as num).toDouble(),
      discountPrice: (json['discount_price'] as double?),
      finalPrice: (json['final_price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      ratingCount: json['rating_count'] as int,
      hasOffer: json['has_offer'] as bool,
      isFeatured: json['is_featured'] as bool,
      inStock: json['in_stock'] as bool,
      features: json['features']?.toString() ?? '',
    );
  }
}
