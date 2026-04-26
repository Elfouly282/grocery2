import 'package:equatable/equatable.dart';

class SmartListEntity extends Equatable {
  final int id;
  final String title;
  final String? description;
  final String image;
  final int itemCount;
  final DateTime createdAt;

  const SmartListEntity({
    required this.id,
    required this.title,
    this.description,
    required this.image,
    required this.itemCount,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    image,
    itemCount,
    createdAt,
  ];
}
