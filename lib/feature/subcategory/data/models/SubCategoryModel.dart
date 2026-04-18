class SubCategoryModel {
  final int id;
  final String name;
  final String slug;
  final String description;
  final String? imageUrl;
  final int mealsCount;
  final int sortOrder;
  final DateTime createdAt;

  SubCategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.imageUrl,
    required this.mealsCount,
    required this.sortOrder,
    required this.createdAt,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'],
      mealsCount: json['meals_count'] ?? 0,
      sortOrder: json['sort_order'] ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),    );
  }
}