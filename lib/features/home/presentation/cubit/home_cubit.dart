import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/api_constant.dart';
import '../../../../core/constants/dio_helper.dart';
import '../../../category/data/models/CategoryModel.dart';
import '../../data/model/deals_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getHomeData() async {
    emit(HomeLoading());

    try {
      final dealsResponse = await DioHelper.get(
        path: ApiConstant.todayDeals,
        withAuth: false,
      );

      final categoriesResponse = await DioHelper.get(
        path: ApiConstant.category,
        withAuth: false,
      );

      final deals = (dealsResponse.data['data'] as List)
          .map((e) => DealModel.fromJson(e))
          .toList();

      final categories = (categoriesResponse.data['data'] as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList();

      emit(HomeSuccess(deals: deals, categories: categories));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
