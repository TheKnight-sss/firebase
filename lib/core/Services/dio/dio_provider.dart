import 'package:bookia/core/Services/dio/api_endpoint.dart';
import 'package:dio/dio.dart';

class DioProvider {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndPoint.baseUrl,
        connectTimeout: Duration(seconds: 2),
      ),
    );
  }

  static Future<Response> post({
    required String endpoint,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.post(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  static Future<Response> get({
    required String endpoint,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.get(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  static Future<Response> put({
    required String endpoint,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.put(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  static Future<Response> delete({
    required String endpoint,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.delete(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  static Future<Response> patch({
    required String endpoint,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.patch(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }
}
