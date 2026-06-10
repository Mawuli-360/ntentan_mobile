import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  factory ApiException.fromDioError(DioException e) {
    String message;
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout";
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout";
        break;
      case DioExceptionType.badResponse:
        message = _handleBadResponse(e.response);
        break;
      case DioExceptionType.cancel:
        message = "Request was cancelled";
        break;
      case DioExceptionType.connectionError:
        message = "Connection error";
        break;
      case DioExceptionType.unknown:
        message = "An unknown error occurred";
        break;
      default:
        message = "An unexpected error occurred";
    }

    return ApiException(message: message, statusCode: e.response?.statusCode);
  }

  static String _handleBadResponse(Response? response) {
    if (response == null) {
      return "An unknown error occurred";
    }
    if (response.data is Map && response.data['message'] != null) {
      return response.data['message'];
    }
    switch (response.statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not found';
      case 500:
        return 'Internal server error';
      default:
        return 'Received invalid status code: ${response.statusCode}';
    }
  }

  @override
  String toString() => 'ApiException: $message (Status code: $statusCode)';
}
