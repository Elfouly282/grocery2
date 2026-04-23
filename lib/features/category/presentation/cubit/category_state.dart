part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryError extends CategoryState {
  final String message;
  CategoryError({required this.message});
}

class CategorySuccess extends CategoryState {
  final CategoriesResponse categories;
  final int selectedIndex;
  final DetailsMealsResponse? details;
  final bool isDetailsLoading;

  CategorySuccess({
    required this.categories,
    this.selectedIndex = 0,
    this.details,
    this.isDetailsLoading = false,
  });

  CategorySuccess copyWith({
    int? selectedIndex,
    DetailsMealsResponse? details,
    bool? isDetailsLoading,
  }) {
    return CategorySuccess(
      categories: categories,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      details: details ?? this.details,
      isDetailsLoading: isDetailsLoading ?? this.isDetailsLoading,
    );
  }
}