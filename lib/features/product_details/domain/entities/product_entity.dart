class ProductEntity {
  final int id;
  final String title;
  final String slug;
  final String description;
  final String image;
  final String? offerTitle;
  final DateTime expiryDate;
  final double price;
  final double discountPrice;
  final double finalPrice;
  final double rating;
  final int ratingCount;
  final bool hasOffer;
  final bool isFeatured;
  final String features;
  final String size;
  final String? brand;
  final String includes;
  final String? howToUse;
  final bool isExpired;
  final int stockQuantity;
  final bool inStock;
  final int soldCount;
  final bool isAvailable;
  final CategoryEntity? category;
  final CategoryEntity? subcategory;

  ProductEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.image,
    this.offerTitle,
    required this.price,
    required this.discountPrice,
    required this.finalPrice,
    required this.rating,
    required this.ratingCount,
    required this.hasOffer,
    required this.isFeatured,
    required this.features,
    required this.size,
    this.brand,
    required this.includes,
    this.howToUse,
    required this.stockQuantity,
    required this.inStock,
    required this.soldCount,
    required this.isAvailable,
    this.category,
    this.subcategory,
    required this.expiryDate,
    required this.isExpired,
  });
}

class CategoryEntity {
  final int id;
  final String name;
  final String slug;

  CategoryEntity({required this.id, required this.name, required this.slug});
}
