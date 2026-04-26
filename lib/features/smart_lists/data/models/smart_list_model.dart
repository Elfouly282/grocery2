import '../../domain/entities/smart_list_entity.dart';

class SmartListModel extends SmartListEntity {
  const SmartListModel({
    required super.id,
    required super.title,
    super.description,
    required super.image,
    required super.itemCount,
    required super.createdAt,
  });

  factory SmartListModel.fromJson(Map<String, dynamic> json) {
    // TODO: Implement JSON parsing
    return SmartListModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'],
      image: json['image'] ?? '',
      itemCount: json['item_count'] ?? 0,
      createdAt: DateTime.now(),
    );
  }

  SmartListEntity toEntity() {
    return SmartListEntity(
      id: id,
      title: title,
      description: description,
      image: image,
      itemCount: itemCount,
      createdAt: createdAt,
    );
  }
}
