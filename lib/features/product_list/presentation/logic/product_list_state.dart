part of 'product_list_cubit.dart';

class ProductListState {
  const ProductListState({
    this.subcategoriesRequestStatus = RequestStatusEnum.initial,
    this.mealsRequestStatus = RequestStatusEnum.initial,
    this.meals = const [],
    this.filteredSubcategories = const [],
    this.selectedSubcategoryId,
    this.errorMessage,
    this.pagination,
  });

  /// Loading/Error status for subcategories fetching and filtering
  final RequestStatusEnum subcategoriesRequestStatus;

  /// Filtered subcategories based on the selected category ID
  /// Only contains subcategories where category.id matches the initialCategoryId
  final List<SubCategoriesModel> filteredSubcategories;

  /// Loading/Error status for meals fetching
  final RequestStatusEnum mealsRequestStatus;

  /// Meals (products) of the selected subcategory
  final List<MealsModel> meals;

  /// The currently selected subcategory ID
  final int? selectedSubcategoryId;

  /// Error message if any operation fails
  final String? errorMessage;

  /// Pagination information for meals
  final Pagination? pagination;

  /// Check if there are more pages to load
  bool get hasNextPage => pagination?.hasNextPage ?? false;

  /// Check if subcategories are loading
  bool get isLoadingSubcategories =>
      subcategoriesRequestStatus == RequestStatusEnum.loading;

  /// Check if meals are loading
  bool get isLoadingMeals => mealsRequestStatus == RequestStatusEnum.loading;

  /// Check if any error occurred
  bool get hasError =>
      subcategoriesRequestStatus == RequestStatusEnum.error ||
      mealsRequestStatus == RequestStatusEnum.error;

  ProductListState copyWith({
    RequestStatusEnum? subcategoriesRequestStatus,
    List<SubCategoriesModel>? filteredSubcategories,
    RequestStatusEnum? mealsRequestStatus,
    List<MealsModel>? meals,
    Pagination? pagination,
    int? selectedSubcategoryId,
    String? errorMessage,
  }) {
    return ProductListState(
      subcategoriesRequestStatus:
          subcategoriesRequestStatus ?? this.subcategoriesRequestStatus,
      filteredSubcategories:
          filteredSubcategories ?? this.filteredSubcategories,
      mealsRequestStatus: mealsRequestStatus ?? this.mealsRequestStatus,
      meals: meals ?? this.meals,
      selectedSubcategoryId:
          selectedSubcategoryId ?? this.selectedSubcategoryId,
      errorMessage: errorMessage,
      pagination: pagination ?? this.pagination,
    );
  }
}
