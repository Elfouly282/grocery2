import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../data/logic/repo/sub_catigory_repo_impl.dart';
import '../../data/models/SubCategoriesResponse.dart';
import 'package:dio/dio.dart';

part 'subcategory_state.dart';

class SubcategoryCubit extends Cubit<SubcategoryState> {

  final CategoryRepoImpl catigoryRepo;
  SubcategoryCubit(this.catigoryRepo) : super(SubcategoryInitial());


  Future<void> getCategory() async {
    emit(SubcategoryLoading());
    try {
      final categories = await catigoryRepo.getSubCategories();
      emit(SubcategorySuccess(
        categories: categories,
        selectedIndex: 0,
      ));
    } catch (e) {
      emit(SubcategoryError(message: _handleError(e)));
    }
  }

  void selectCategory(int index) {
    final current = state;
    if (current is SubcategorySuccess) {
      emit(current.copyWith(selectedIndex: index));
    }
  }




  String _handleError(dynamic e) {
    if (e is DioException) {
      final data = e.response?.data;

      if (data != null && data['errors'] != null) {
        final errors = data['errors'] as Map<String, dynamic>;
        return errors.values.first[0];
      }

      return data?['message'] ?? 'Network error';
    }

    return e.toString();
  }

}
