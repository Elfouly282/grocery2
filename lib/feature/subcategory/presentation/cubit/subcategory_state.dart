part of 'subcategory_cubit.dart';

@immutable
sealed class SubcategoryState {}

final class SubcategoryInitial extends SubcategoryState {}

class SubcategoryLoading extends SubcategoryState {}

class SubcategoryError extends SubcategoryState {
  final String message;
  SubcategoryError({required this.message});
}

class SubcategorySuccess extends SubcategoryState {
  final SubCategoriesResponse categories;
  final int selectedIndex;

  SubcategorySuccess({
    required this.categories,
    this.selectedIndex = 0,
  });

  SubcategorySuccess copyWith({
    int? selectedIndex,
  }) {
    return SubcategorySuccess(
      categories: categories,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}

