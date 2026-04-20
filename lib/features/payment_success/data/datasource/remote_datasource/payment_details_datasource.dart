import 'package:dio/dio.dart';
import 'package:grocery2/core/constants/api_constant.dart';
import 'package:grocery2/core/constants/dio_helper.dart';
import 'package:grocery2/features/payment_success/data/model/payment_receipt_model.dart';

abstract class BasePaymentDetailsDatasource {
  Future<PaymentReceiptModel> getPaymentReceipt(int orderId);
}

class PaymentDetailsDatasource implements BasePaymentDetailsDatasource {
  @override
  Future<PaymentReceiptModel> getPaymentReceipt(int orderId) async {
    try {
      final response = await DioHelper.get(
        path: ApiConstant.paymentReceipt(orderId),
        withAuth: true,
      );

      return PaymentReceiptModel.fromJson(response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }
}

Exception _handleDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
      return Exception('Connection timed out. Please try again.');
    case DioExceptionType.connectionError:
      return Exception('No internet connection.');
    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      final message = e.response?.data['message'] as String? ?? 'Something went wrong.';
      if (statusCode == 401) return Exception('Unauthorized. Please log in again.');
      if (statusCode == 404) return Exception('Order not found.');
      if (statusCode == 422) return Exception(message);
      return Exception(message);
    default:
      return Exception('Unexpected error. Please try again.');
  }
}
