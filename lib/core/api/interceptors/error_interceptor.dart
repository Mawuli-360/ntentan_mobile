import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(
      DioException(
        message: err.response?.data['message'] ?? err.message,
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
      ),
    );
  }
}
