import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.title,
    required super.slug,
    required super.description,
    required super.image,
    super.offerTitle,
    required super.price,
    super.discountPrice,
    required super.finalPrice,
    required super.rating,
    required super.ratingCount,
    required super.hasOffer,
    required super.isFeatured,
    required super.features,
    required super.size,
    super.brand,
    required super.includes,
    super.howToUse,
    required super.stockQuantity,
    required super.inStock,
    required super.soldCount,
    required super.isAvailable,
    required super.expiryDate,
    required super.isExpired,

    super.isFavorited = false,
    super.favoritedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'] ?? "",
      slug: json['slug'] ?? "",
      description: json['description'] ?? "",
      image: json['image_url'] ?? "",
      offerTitle: json['offer_title'],
      expiryDate: json['expiry_date'] != null
          ? DateTime.tryParse(json['expiry_date'] as String) ??
                DateTime(1970, 1, 1)
          : DateTime(1970, 1, 1),
      isExpired: json['is_expired'] ?? false,
      price: (json['price'] ?? 0).toDouble(),
      discountPrice: json['discount_price'] != null
          ? (json['discount_price'] as num).toDouble()
          : null,
      finalPrice: (json['final_price'] ?? json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      ratingCount: json['rating_count'] ?? 0,
      hasOffer: json['has_offer'] ?? false,
      isFeatured: json['is_featured'] ?? false,
      features: json['features'] ?? "",
      size: json['size'] ?? "",
      brand: json['brand'],
      includes: json['includes'] ?? "",
      howToUse: json['how_to_use'],
      stockQuantity: json['stock_quantity'] ?? 0,
      inStock: json['in_stock'] ?? false,
      soldCount: json['sold_count'] ?? 0,
      isAvailable: json['is_available'] ?? false,

      isFavorited: json['is_favorited'] ?? false,
      favoritedAt: json['favorited_at'] != null
          ? DateTime.tryParse(json['favorited_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'description': description,
      'image_url': image,
      'offer_title': offerTitle,
      'expiry_date': expiryDate.toIso8601String(),
      'is_expired': isExpired,
      'price': price,
      'discount_price': discountPrice,
      'final_price': finalPrice,
      'rating': rating,
      'rating_count': ratingCount,
      'has_offer': hasOffer,
      'is_featured': isFeatured,
      'features': features,
      'size': size,
      'brand': brand,
      'includes': includes,
      'how_to_use': howToUse,
      'stock_quantity': stockQuantity,
      'in_stock': inStock,
      'sold_count': soldCount,
      'is_available': isAvailable,
      'is_favorited': isFavorited,
      'favorited_at': favoritedAt?.toIso8601String(),
    };
  }
}
