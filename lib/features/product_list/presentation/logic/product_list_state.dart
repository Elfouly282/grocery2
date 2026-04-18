part of 'product_list_cubit.dart';

class ProductListState {
  ProductListState({
    this.subcategoriesRequestStatus = RequestStatusEnum.loading,
    this.mealsRequestStatus = RequestStatusEnum.loading,
    this.meals = const [],
    this.subcategories = const [],
    this.selectedSubcategoryId,
    this.errorMessage,
    this.pagination,
  });

  final RequestStatusEnum subcategoriesRequestStatus;
  final List<SubCategoriesModel> subcategories;
  final RequestStatusEnum mealsRequestStatus;
  final List<MealsModel> meals;
  final int? selectedSubcategoryId;
  final String? errorMessage;
  final Pagination? pagination;
  bool get hasNextPage => pagination?.hasNextPage ?? false;


  ProductListState copyWith({
    RequestStatusEnum? subcategoriesRequestStatus,
    List<SubCategoriesModel>? subcategories,
    errorMessage,
    RequestStatusEnum? mealsRequestStatus,
    List<MealsModel>? meals,
    Pagination? pagination,
    int? selectedSubcategoryId,
  }) {
    return ProductListState(
      subcategoriesRequestStatus:
          subcategoriesRequestStatus ?? this.subcategoriesRequestStatus,
      subcategories: subcategories ?? this.subcategories,
      mealsRequestStatus: mealsRequestStatus ?? this.mealsRequestStatus,
      meals: meals ?? this.meals,
      selectedSubcategoryId: selectedSubcategoryId ?? this.selectedSubcategoryId,
      errorMessage: errorMessage,
      pagination: pagination ?? this.pagination,
    );
  }
}
