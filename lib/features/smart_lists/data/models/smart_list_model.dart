import '../../domain/entities/smart_list_entity.dart';

class SmartListModel extends SmartListEntity {
  const SmartListModel({required super.id});

  factory SmartListModel.fromJson(Map<String, dynamic> json) {
    // TODO: Implement JSON parsing
    return SmartListModel(id: json['id'] ?? 0);
  }

  SmartListEntity toEntity() {
    return SmartListEntity(id: id);
  }
}
