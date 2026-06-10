import 'package:dio/dio.dart';
import 'package:ntentan/core/constants/logger.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    AppLogger.i('🌐 REQUEST[${options.method}] => PATH: $requestPath');

    if (options.queryParameters.isNotEmpty) {
      AppLogger.i('Query Parameters: ${options.queryParameters}');
    }

    if (options.data != null) {
      AppLogger.i('Request Body: ${options.data}');
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.i(
      '✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );

    if (response.data != null) {
      AppLogger.i('Response Body: ${response.data}');
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.e(
      '❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );

    if (err.response?.data != null) {
      AppLogger.e('Error Body: ${err.response?.data["message"]}]');
    }

    handler.next(err);
  }
}
