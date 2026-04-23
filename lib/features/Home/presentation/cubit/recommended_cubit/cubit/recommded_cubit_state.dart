// States
 import 'package:grocery2/features/Home/data/recommended_model.dart';

abstract class RecommendationState {}
class RecommendationInitial extends RecommendationState {}
class RecommendationLoading extends RecommendationState {}
class RecommendationSuccess extends RecommendationState {
  final List<MealRecommendationModel> meals;
  RecommendationSuccess(this.meals);
}
class RecommendationError extends RecommendationState {
  final String message;
  RecommendationError(this.message);
}
 