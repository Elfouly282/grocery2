import 'package:equatable/equatable.dart';

class HistoryItemEntity extends Equatable {
  final int id;
  final int productId;
  final String productTitle;
  final String productImage;
  final double price;
  final int quantity;
  final DateTime purchasedAt;

  const HistoryItemEntity({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.productImage,
    required this.price,
    required this.quantity,
    required this.purchasedAt,
  });

  @override
  List<Object?> get props => [
    id,
    productId,
    productTitle,
    productImage,
    price,
    quantity,
    purchasedAt,
  ];
}
