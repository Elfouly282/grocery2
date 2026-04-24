import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery2/core/enums/request_status_enum.dart';
import 'package:grocery2/features/product_list/data/model/meals_model.dart';
import 'package:grocery2/features/product_list/data/model/pagination_model.dart';
import 'package:grocery2/features/product_list/data/model/subcategories_model.dart';
import 'package:grocery2/features/product_list/data/repository/subcategories_repository.dart';

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  final BaseSubcategoriesRepository baseSubcategoriesRepository;
  final String _initialCategoryId; // Store the initial category ID as String for comparison

  ProductListCubit(
    this.baseSubcategoriesRepository, {
    required int categoryId,
  })  : _initialCategoryId = categoryId.toString(),
        super(const ProductListState());

  /// Fetch and filter subcategories, then auto-select the first one and fetch its meals
  Future<void> fetchSubcategoriesAndMeals() async {
    await _fetchAndFilterSubcategories();
  }

  /// Fetch all subcategories from API and filter locally by category ID
  Future<void> _fetchAndFilterSubcategories() async {
    try {
      emit(
        state.copyWith(
          subcategoriesRequestStatus: RequestStatusEnum.loading,
          mealsRequestStatus: RequestStatusEnum.loading,
          errorMessage: null,
        ),
      );

      // Fetch all subcategories from API
      final allSubcategories =
          await baseSubcategoriesRepository.getSubCategories();

      if (allSubcategories == null || allSubcategories.isEmpty) {
        emit(
          state.copyWith(
            subcategoriesRequestStatus: RequestStatusEnum.loaded,
            mealsRequestStatus: RequestStatusEnum.loaded,
            filteredSubcategories: const [],
            errorMessage: null,
          ),
        );
        return;
      }

      // Filter subcategories locally by matching category.id with initialCategoryId
      final filteredSubcategories = allSubcategories
          .where((sub) =>
              sub.category != null &&
              sub.category!.id.toString() == _initialCategoryId)
          .toList();

      // Update state with filtered subcategories
      emit(
        state.copyWith(
          subcategoriesRequestStatus: RequestStatusEnum.loaded,
          filteredSubcategories: filteredSubcategories,
          errorMessage: null,
        ),
      );

      // Auto-select the first filtered subcategory and fetch its meals
      if (filteredSubcategories.isNotEmpty) {
        await _selectAndFetchFirstSubcategory(filteredSubcategories[0]);
      } else {
        // No filtered subcategories found
        emit(
          state.copyWith(
            mealsRequestStatus: RequestStatusEnum.loaded,
            meals: const [],
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          subcategoriesRequestStatus: RequestStatusEnum.error,
          mealsRequestStatus: RequestStatusEnum.error,
          errorMessage: 'Failed to load subcategories: ${e.toString()}',
        ),
      );
    }
  }

  /// Select the first subcategory and immediately fetch its meals
  Future<void> _selectAndFetchFirstSubcategory(
      SubCategoriesModel subcategory) async {
    try {
      // Parse subId safely from String to int
      final subCategoryIntId = _parseSubIdToInt(subcategory.subId);

      if (subCategoryIntId == null) {
        emit(
          state.copyWith(
            mealsRequestStatus: RequestStatusEnum.error,
            errorMessage:
                'Invalid subcategory ID: ${subcategory.subId}. Expected numeric value.',
          ),
        );
        return;
      }

      // Update state with the selected subcategory
      emit(
        state.copyWith(
          selectedSubcategoryId: subCategoryIntId,
          mealsRequestStatus: RequestStatusEnum.loading,
        ),
      );

      // Fetch meals for the selected subcategory (page 1)
      await _fetchMeals(subCategoryIntId, reset: true);
    } catch (e) {
      emit(
        state.copyWith(
          mealsRequestStatus: RequestStatusEnum.error,
          errorMessage: 'Failed to select subcategory: ${e.toString()}',
        ),
      );
    }
  }

  /// Select a subcategory and fetch its meals
  void selectSubcategory(int subCategoryId) {
    // Avoid redundant API calls if the same subcategory is already selected
    if (state.selectedSubcategoryId == subCategoryId &&
        state.meals.isNotEmpty) {
      return;
    }

    emit(
      state.copyWith(
        selectedSubcategoryId: subCategoryId,
        meals: const [],
        pagination: null,
        mealsRequestStatus: RequestStatusEnum.loading,
      ),
    );

    _fetchMeals(subCategoryId, reset: true);
  }

  /// Fetch meals for a subcategory with pagination support
  Future<void> _fetchMeals(int subCategoryId, {bool reset = false}) async {
    try {
      // Only fetch if subcategory ID is valid
      if (subCategoryId <= 0) {
        emit(
          state.copyWith(
            mealsRequestStatus: RequestStatusEnum.error,
            errorMessage: 'Invalid subcategory ID',
          ),
        );
        return;
      }

      // Determine the page to fetch
      final page = reset ? 1 : (state.pagination?.currentPage ?? 0) + 1;

      // Fetch meals from repository
      final dataModel = await baseSubcategoriesRepository.getMeals(
        id: subCategoryId,
        page: page,
      );

      // Combine meals with previous results (or replace if reset)
      final updatedMeals =
          reset ? dataModel.meals : [...state.meals, ...dataModel.meals];

      emit(
        state.copyWith(
          mealsRequestStatus: RequestStatusEnum.loaded,
          meals: updatedMeals,
          pagination: dataModel.pagination,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          mealsRequestStatus: RequestStatusEnum.error,
          errorMessage: 'Failed to load meals: ${e.toString()}',
        ),
      );
    }
  }

  /// Load more meals (pagination)
  Future<void> loadMoreMeals() async {
    if (state.selectedSubcategoryId == null) return;
    if (!state.hasNextPage) return;

    await _fetchMeals(state.selectedSubcategoryId!, reset: false);
  }

  /// Parse subId from String to int safely
  /// Returns null if parsing fails
  int? _parseSubIdToInt(String subId) {
    try {
      return int.parse(subId);
    } catch (e) {
      return null;
    }
  }

  void toggleFavorite(String mealId) {
    // Logic to toggle favorite (e.g., call API or update local storage)
    print("Toggled favorite for meal: $mealId");
  }

  void addToCart(MealsModel meal) {
    // Logic to add to cart
    print("Added to cart: ${meal.mealTitle}");
  }
}
