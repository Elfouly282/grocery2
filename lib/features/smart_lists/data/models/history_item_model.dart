import '../../domain/entities/history_item_entity.dart';

class HistoryItemModel extends HistoryItemEntity {
  const HistoryItemModel({
    required super.id,
    required super.productId,
    required super.productTitle,
    required super.productImage,
    required super.price,
    required super.quantity,
    required super.purchasedAt,
  });

  factory HistoryItemModel.fromJson(Map<String, dynamic> json) {
    // TODO: Implement JSON parsing
    return HistoryItemModel(
      id: json['id'] ?? 0,
      productId: json['product_id'] ?? 0,
      productTitle: json['product_title'] ?? '',
      productImage: json['product_image'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
      purchasedAt: DateTime.now(),
    );
  }

  HistoryItemEntity toEntity() {
    return HistoryItemEntity(
      id: id,
      productId: productId,
      productTitle: productTitle,
      productImage: productImage,
      price: price,
      quantity: quantity,
      purchasedAt: purchasedAt,
    );
  }
}
