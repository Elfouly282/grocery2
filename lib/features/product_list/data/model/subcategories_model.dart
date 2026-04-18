import 'category_model.dart';

class SubCategoriesModel {
  SubCategoriesModel({
    required this.subId,
    required this.name,
    required this.subSlug,
     this.description,
     this.image,
     this.category,
     this.order,
     this.mealsCount,
     this.createdAt,
  });

  final String subId;
  final String name;
  final String subSlug;
  final String? description;
  final String? image;
  Category? category;
  final String? order;
  final int? mealsCount;
  final DateTime? createdAt;

  Map<String, dynamic> toJson() {
    return {
      "id": subId,
      "name": name,
      "slug": subSlug,
      "description": description,
      "image_url": image,
      "category": category?.toJson(),
      "order": order,
      "meals_count": mealsCount,
      "created_at": createdAt?.toIso8601String(),
    };
  }

  factory SubCategoriesModel.fromJson(Map<String, dynamic> json) {
    return SubCategoriesModel(
      subId: json["id"]?.toString() ?? '',
      name: json["name"]?.toString() ?? '',
      subSlug: json["slug"]?.toString() ?? '',
      description: json["description"]?.toString() ?? '',
      image: json["image_url"],
      category: Category.fromJson(json["category"] ?? {}),
      order: json["order"]?.toString() ?? '',
      mealsCount: json["meals_count"] is int 
          ? json["meals_count"] 
          : int.tryParse(json["meals_count"]?.toString() ?? '0') ?? 0,
      createdAt: json["created_at"] != null 
          ? DateTime.parse(json["created_at"]) 
          : DateTime.now(),
    );
  }
}
