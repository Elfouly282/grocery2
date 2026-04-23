import 'package:grocery2/core/constants/api_constant.dart';
import 'package:grocery2/core/constants/dio_helper.dart';
 import 'package:grocery2/features/home/data/model/recommended_model.dart';

class RecommendationRepository {
  // List<MealRecommendationModel> getRecommendations() {
  //    List<dynamic> jsonData = [ /* البيانات التي أرسلتها سابقاً */ ];
  //   return jsonData.map((item) => MealRecommendationModel.fromJson(item)).toList();
  // }
  Future<List<MealRecommendationModel>> getRecommendations() async {
    try {
      final response = await DioHelper.get(path: ApiConstant.todaysdeals);
      if (response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;
        final List<dynamic> data = responseData['data'] ?? [];

        return data
            .map((json) => MealRecommendationModel.fromJson(json))
            .toList();
      } else {
        throw "Unexpected response format";
      }
    } catch (e) {
      rethrow;
    }
  }
}