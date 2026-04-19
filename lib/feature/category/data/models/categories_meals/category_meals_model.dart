class CategoryMeals {
  final int id;
  final String name;
  final String slug;
  final String description;
  final String? imageUrl;
  final int order;
  final bool isActive;
  final Category category;
  final List<Meal> meals;
  final int mealsCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  CategoryMeals({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    this.imageUrl,
    required this.order,
    required this.isActive,
    required this.category,
    required this.meals,
    required this.mealsCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryMeals.fromJson(Map<String, dynamic> json) {
    return CategoryMeals(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      imageUrl: json['image_url'],
      order: json['order'],
      isActive: json['is_active'],
      category: Category.fromJson(json['category']),
      meals: (json['meals'] as List? ?? [])
          .map((e) => Meal.fromJson(e))
          .toList(),
      mealsCount: json['meals_count'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}


class Category {
  final int id;
  final String name;
  final String slug;

  Category({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}


class Meal {
  final int id;
  final String title;
  final String slug;
  final String imageUrl;
  final double price;
  final double discountPrice;
  final double finalPrice;
  final double rating;
  final bool isFeatured;
  final String features;

  Meal({
    required this.id,
    required this.title,
    required this.slug,
    required this.imageUrl,
    required this.price,
    required this.discountPrice,
    required this.finalPrice,
    required this.rating,
    required this.isFeatured,
    required this.features,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      imageUrl: json['image_url'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      discountPrice: (json['discount_price'] ?? 0).toDouble(),
      finalPrice: (json['final_price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      isFeatured: json['is_featured'] ?? false,
      features: json['features'] ?? '',
    );
  }
}