import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import '../../data/logic/repo/category_repo_impl.dart';
import '../../data/models/CategoriesResponse.dart';
import '../../data/models/categories_meals/category_meals_response.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepoImpl catigoryRepo;

  CategoryCubit(this.catigoryRepo) : super(CategoryInitial());

  Future<void> getCategory() async {
    emit(CategoryLoading());

    try {
      final categories = await catigoryRepo.getSubCategories();

      emit(CategorySuccess(
        categories: categories,
        selectedIndex: 0,
      ));

      getDetails(categories.data.first.id);

    } catch (e) {
      emit(CategoryError(message: _handleError(e)));
    }
  }

  void selectCategory(int index) {
    final current = state;
    if (current is CategorySuccess) {
      final id = current.categories.data[index].id;
      emit(current.copyWith(
        selectedIndex: index,
        isDetailsLoading: true,
      ));
      getDetails(id);
    }
  }

  Future<void> getDetails(int id) async {
    final current = state;

    if (current is CategorySuccess) {
      try {
        final details = await catigoryRepo.getDetailsSubCategories(id);

        emit(current.copyWith(
          details: details,
          isDetailsLoading: false,
        ));
      } catch (e) {
        emit(CategoryError(message: _handleError(e)));
      }
    }
  }

  String _handleError(dynamic e) {
    if (e is DioException) {
      final data = e.response?.data;

      if (data != null && data['message'] != null) {
        return data['message'];
      }
    }
    return e.toString();
  }
}