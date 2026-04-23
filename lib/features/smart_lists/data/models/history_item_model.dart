import '../../domain/entities/history_item_entity.dart';

class HistoryItemModel extends HistoryItemEntity {
  const HistoryItemModel({required super.id});

  factory HistoryItemModel.fromJson(Map<String, dynamic> json) {
    // TODO: Implement JSON parsing
    return HistoryItemModel(id: json['id'] ?? 0);
  }

  HistoryItemEntity toEntity() {
    return HistoryItemEntity(id: id);
  }
}
