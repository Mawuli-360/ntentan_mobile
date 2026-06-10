import 'package:dio/dio.dart';
import 'package:ntentan/core/constants/logger.dart';
import 'package:ntentan/core/manager/token_manager.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await TokenManager.getToken();

    if (token != null) {
      AppLogger.i('Adding Authorization: Bearer $token');
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshed = await TokenManager.refreshToken();

      if (refreshed) {
        // Retry the request with new token
        final token = await TokenManager.getToken();
        final opts = Options(
          method: err.requestOptions.method,
          headers: {
            ...err.requestOptions.headers,
            'Authorization': 'Bearer $token',
          },
        );

        try {
          final response = await Dio().request<dynamic>(
            err.requestOptions.path,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
            options: opts,
          );

          return handler.resolve(response);
        } on DioException catch (e) {
          return handler.next(e);
        }
      }
    }

    return handler.next(err);
  }
}
