import 'package:equatable/equatable.dart';

class FavoriteEntity extends Equatable {
  final int id;
  final int productId;
  final String productTitle;
  final String productImage;
  final double price;
  final DateTime addedAt;

  const FavoriteEntity({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.productImage,
    required this.price,
    required this.addedAt,
  });

  @override
  List<Object?> get props => [
    id,
    productId,
    productTitle,
    productImage,
    price,
    addedAt,
  ];
}
