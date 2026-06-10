import 'package:ntentan/core/api/api_client.dart';
import 'package:ntentan/core/constants/logger.dart';
import 'package:ntentan/features/emergency/data/medical_alert_response.dart';

class MedicalAlertRestService {
  Future<MedicalAlertResponse> sendAlert({
    required String baseUrl,
    required double latitude,
    required double longitude,
  }) async {
    final apiClient = ApiClient(baseUrl: baseUrl);

    AppLogger.i('Sending Medical Alert to: $baseUrl (lat: $latitude, lng: $longitude)');

    try {
      final response = await apiClient.post(
        '/api/medical-alert/send',
        data: {
          'latitude': latitude,
          'longitude': longitude,
        },
      );

      final alertResponse = MedicalAlertResponse.fromJson(response);
      return alertResponse;
    } catch (e) {
      AppLogger.e('Medical Alert REST API error: $e');
      rethrow;
    }
  }
}
