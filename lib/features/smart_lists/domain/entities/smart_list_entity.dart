import 'package:equatable/equatable.dart';

class SmartListMealEntity extends Equatable {
  final int id;
  final String title;
  final String slug;
  final String? description;
  final String image;
  final String? offerTitle;

  const SmartListMealEntity({
    required this.id,
    required this.title,
    required this.slug,
    this.description,
    required this.image,
    this.offerTitle,
  });

  @override
  List<Object?> get props => [id, title, slug, description, image, offerTitle];
}

class SmartListEntity extends Equatable {
  final int id;
  final String name;
  final String? category;
  final String? description;
  final String? image;
  final bool notifyOnPriceDrop;
  final bool notifyOnOffers;
  final List<SmartListMealEntity>? meals;

  const SmartListEntity({
    required this.id,
    required this.name,
    this.category,
    this.description,
    this.image,
    this.notifyOnPriceDrop = false,
    this.notifyOnOffers = false,
    this.meals,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    category,
    description,
    image,
    notifyOnPriceDrop,
    notifyOnOffers,
    meals,
  ];
}
