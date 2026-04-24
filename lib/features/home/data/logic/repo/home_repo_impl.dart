import 'package:dio/dio.dart';

import '../../../../../core/constants/api_constant.dart';
import '../../../../../core/constants/dio_helper.dart';
import '../../model/deals_model.dart';

class DealsRepoImpl {
  @override
  Future<List<DealModel>> getTodayDeals() async {
    try {
      final response = await DioHelper.get(
        path: ApiConstant.todayDeals,
        withAuth: false,
      );
      final List data = response.data['data'];

      return data.map((e) => DealModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception(_handleError(e));
    }
  }

  String _handleError(dynamic error) {
    if (error is DioException) {
      return error.response?.data['message'] ?? 'Server error';
    }
    return 'Unexpected error';
  }
}
