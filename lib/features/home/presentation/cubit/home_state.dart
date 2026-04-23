import '../../../category/data/models/CategoryModel.dart';
import '../../data/model/deals_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<DealModel> deals;
  final List<CategoryModel> categories;

  HomeSuccess({
    required this.deals,
    required this.categories,
  });
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}