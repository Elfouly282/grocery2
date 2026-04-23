import 'package:grocery2/core/constants/api_constant.dart';
import 'package:grocery2/core/constants/dio_helper.dart';
import 'package:grocery2/features/Home/data/today_deal.dart';
 
class DealsRepository{
  Future<List<DealModel>> getDeals() async {
    try {
      final response = await DioHelper.get(path: ApiConstant.todaysdeals);

      if (response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;
        final List<dynamic> data = responseData['data'] ?? [];
        
        return data.map((json) => DealModel.fromJson(json)).toList();
      } else {
        throw "Unexpected response format";
      }
    } catch (e) {
      rethrow;
    }
  }

}



