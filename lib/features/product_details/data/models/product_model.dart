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
    required super.discountPrice,
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
    super.category,
    super.subcategory,
    required super.expiryDate,
    required super.isExpired,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      slug: json['slug'] ?? "",
      description: json['description'],
      image: (json['image_url'] ?? "")
          .toString()
          .trim(), // Ensure image URL is always a non-null String
      offerTitle: json['offer_title'],
      expiryDate: json['expiry_date'] != null
          ? DateTime.tryParse(json['expiry_date'] as String) ??
                DateTime(1970, 1, 1)
          : DateTime(1970, 1, 1),
      isExpired: json['is_expired'] ?? false,
      price: (json['price']).toDouble(),
      discountPrice: (json['discount_price']).toDouble(),
      finalPrice: (json['final_price']).toDouble(),
      rating: (json['rating']).toDouble(),
      ratingCount: json['rating_count'],
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
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : null,
      subcategory: json['subcategory'] != null
          ? CategoryModel.fromJson(json['subcategory'])
          : null,
    );
  }
}

class CategoryModel extends CategoryEntity {
  CategoryModel({required super.id, required super.name, required super.slug});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}
