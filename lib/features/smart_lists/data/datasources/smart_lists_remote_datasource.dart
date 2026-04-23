import '../models/smart_list_model.dart';
import '../models/history_item_model.dart';

class SmartListsRemoteDataSource {
  static const String token = "temp_token_123";

  // TODO: Implement DioHelper to inject token in headers
  Future<List<SmartListModel>> getSmartLists() async {
    // TODO: Call API endpoint
    // Example:
    // final response = await DioHelper.get(
    //   path: ApiConstant.getSmartLists,
    //   options: Options(headers: {'Authorization': 'Bearer $token'}),
    // );
    // return (response.data['data'] as List).map((e) => SmartListModel.fromJson(e)).toList();
    return [];
  }

  Future<List<HistoryItemModel>> getHistory() async {
    // TODO: Call API endpoint for history
    // Example:
    // final response = await DioHelper.get(
    //   path: ApiConstant.getHistory,
    //   options: Options(headers: {'Authorization': 'Bearer $token'}),
    // );
    // return (response.data['data'] as List).map((e) => HistoryItemModel.fromJson(e)).toList();
    return [];
  }
}
