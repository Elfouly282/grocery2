class ApiConstant {
  /// Base URL for API endpoints
  static const String baseUrl = 'https://grocery.newcinderella.online/api';

static const String paymentHistory = '/payments/history';

static String paymentReceipt(int orderId)=> '/payments/receipt/$orderId';


  /// Timeout duration in seconds
  static const int connectTimeout = 30;
  static const int receiveTimeout = 30;

  /// Headers
  static const Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
}
