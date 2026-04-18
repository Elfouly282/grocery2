
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
  final String offerTitle;
  final int price;
  final int discountPrice;
  final int finalPrice;
  final String rating;
  final int ratingCount;
  final bool hasOffer;
  final bool isFeatured;
  final bool inStock;
  final String features;

  @override
  String toString() {
    return 'MealsModel{mealId: $mealId, mealTitle: $mealTitle, mealSlug: $mealSlug, mealDescription: $mealDescription, mealImage: $mealImage, offerTitle: $offerTitle, price: $price, discountPrice: $discountPrice, finalPrice: $finalPrice, rating: $rating, ratingCount: $ratingCount, hasOffer: $hasOffer, isFeatured: $isFeatured, inStock: $inStock, features: $features}';
  }

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

  factory MealsModel.fromJson(Map<String, dynamic> map) {
    return MealsModel(
      mealId: map['id']?.toString() ?? '',
      mealTitle: map['title']?.toString() ?? '',
      mealSlug: map['slug']?.toString() ?? '',
      mealDescription: map['description']?.toString() ?? '',
      mealImage: map['image_url']?.toString(),           // nullable — no fallback
      offerTitle: map['offer_title']?.toString() ?? '',
      price: _parseInt(map['price']),
      discountPrice: _parseInt(map['discount_price']),
      finalPrice: _parseInt(map['final_price']),
      rating: map['rating']?.toString() ?? '0',
      ratingCount: _parseInt(map['rating_count']),
      hasOffer: map['has_offer'] == true,
      isFeatured: map['is_featured'] == true,
      inStock: map['in_stock'] == true,
      features: map['features']?.toString() ?? '',
    );
  }

// Helper: safely parse int from int, double, or String
  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }
}
