import 'package:dio/dio.dart';
 

import 'auth_interceptor.dart';
import 'logging_interceptors.dart';

class DioHelper {
  DioHelper._();

  static late Dio _dio;

  static void init({
    required String baseUrl,
    Duration timeout = const Duration(seconds: 30),
    bool enableLogger = true,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: timeout,
        receiveTimeout: timeout,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    _addInterceptors(enableLogger);
  }

  static Dio get dio => _dio;


  static void _addInterceptors(bool enableLogger) {
    _dio.interceptors.add(AuthInterceptor());

    if (enableLogger) {
      _dio.interceptors.add(LoggingInterceptor());
    }
  }

  static Future<Response> get({
    required String path,
    Map<String, dynamic>? query,
    bool withAuth = false,
  }) async {
    return await _dio.get(
      path,
      queryParameters: query,
      options: Options(
        extra: {'withAuth': withAuth},
      ),
    );
  }

  static Future<Response> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? query,
    bool withAuth = false,
  }) async {
    return await _dio.post(
      path,
      data: data,
      queryParameters: query,
      options: Options(
        extra: {'withAuth': withAuth},
      ),
    );
  }


  static Future<Response> put({
    required String path,
    dynamic data,
    Map<String, dynamic>? query,
    bool withAuth = false,
  }) async {
    return await _dio.put(
      path,
      data: data,
      queryParameters: query,
      options: Options(
        extra: {'withAuth': withAuth},
      ),
    );
  }

  static Future<Response> delete({
    required String path,
    dynamic data,
    Map<String, dynamic>? query,
    bool withAuth = false,
  }) async {
    return await _dio.delete(
      path,
      data: data,
      queryParameters: query,
      options: Options(
        extra: {'withAuth': withAuth},
      ),
    );
  }
}