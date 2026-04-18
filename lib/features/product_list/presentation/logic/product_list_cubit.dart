import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery2/core/enums/request_status_enum.dart';
import 'package:grocery2/features/product_list/data/model/meals_model.dart';
import 'package:grocery2/features/product_list/data/model/pagination_model.dart';
import 'package:grocery2/features/product_list/data/model/subcategories_model.dart';
import 'package:grocery2/features/product_list/data/repository/subcategories_repository.dart';

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit(this.baseSubcategoriesRepository) : super(ProductListState()) {
    getSubCategories();
  }

  final BaseSubcategoriesRepository baseSubcategoriesRepository;

  Future<void> getSubCategories() async {
    try {
      emit(
        state.copyWith(
          subcategoriesRequestStatus: RequestStatusEnum.loading,
          errorMessage: null,
        ),
      );

      final subcategories = await baseSubcategoriesRepository.getSubCategories();
      
      emit(
        state.copyWith(
          subcategoriesRequestStatus: RequestStatusEnum.loaded,
          subcategories: subcategories ?? [],
          errorMessage: null,
        ),
      );

      if (subcategories != null && subcategories.isNotEmpty) {
        selectSubcategory(int.parse(subcategories[0].subId));
      }
    } catch (e) {
      emit(
        state.copyWith(
          subcategoriesRequestStatus: RequestStatusEnum.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void selectSubcategory(int id) {
    if (state.selectedSubcategoryId == id && state.meals.isNotEmpty) return;
    
    emit(state.copyWith(
      selectedSubcategoryId: id,
      meals: [],
      pagination: null,
      mealsRequestStatus: RequestStatusEnum.loading,
    ));
    
    getMeals(reset: true);
  }

  Future<void> getMeals({bool reset = false}) async {
    if (state.selectedSubcategoryId == null) return;
    if (!reset && !state.hasNextPage) return;

    try {
      final page = reset ? 1 : (state.pagination?.currentPage ?? 0) + 1;

      final dataModel = await baseSubcategoriesRepository.getMeals(
        id: state.selectedSubcategoryId!,
        page: page,
      );

      final updatedMeals = reset ? dataModel.meals : [...state.meals, ...dataModel.meals];

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
          errorMessage: e.toString(),
        ),
      );
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
