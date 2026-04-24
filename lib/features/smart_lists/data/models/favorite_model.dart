import '../../domain/entities/favorite_entity.dart';

class FavoriteModel extends FavoriteEntity {
  const FavoriteModel({
    required super.id,
    required super.productId,
    required super.productTitle,
    required super.productImage,
    required super.price,
    required super.addedAt,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    // TODO: Implement JSON parsing
    return FavoriteModel(
      id: json['id'] ?? 0,
      productId: json['product_id'] ?? 0,
      productTitle: json['product_title'] ?? '',
      productImage: json['product_image'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      addedAt: DateTime.now(),
    );
  }

  FavoriteEntity toEntity() {
    return FavoriteEntity(
      id: id,
      productId: productId,
      productTitle: productTitle,
      productImage: productImage,
      price: price,
      addedAt: addedAt,
    );
  }
}
