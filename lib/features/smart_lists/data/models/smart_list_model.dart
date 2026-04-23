import '../../domain/entities/smart_list_entity.dart';

class SmartListMealModel extends SmartListMealEntity {
  const SmartListMealModel({
    required super.id,
    required super.title,
    required super.slug,
    super.description,
    required super.image,
    super.offerTitle,
  });

  factory SmartListMealModel.fromJson(Map<String, dynamic> json) {
    return SmartListMealModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'],
      image: json['image_url'] ?? '',
      offerTitle: json['offer_title'],
    );
  }
}

class SmartListModel extends SmartListEntity {
  const SmartListModel({
    required super.id,
    required super.name,
    super.category,
    super.description,
    super.image,
    super.notifyOnPriceDrop,
    super.notifyOnOffers,
    super.meals,
  });

  factory SmartListModel.fromJson(Map<String, dynamic> json) {
    return SmartListModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      category: json['category'],
      description: json['description'],
      image: json['image_url'],
      notifyOnPriceDrop: json['notify_on_price_drop'] ?? false,
      notifyOnOffers: json['notify_on_offers'] ?? false,
      meals: json['meals'] != null
          ? (json['meals'] as List)
                .map((meal) => SmartListMealModel.fromJson(meal))
                .toList()
          : null,
    );
  }
}
