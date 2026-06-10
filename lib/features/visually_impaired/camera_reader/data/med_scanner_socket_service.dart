import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:ntentan/core/constants/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'med_scanner_response.dart';

class MedScannerSocketService {
  io.Socket? _socket;
  final _responseController = StreamController<MedScannerResponse>.broadcast();

  Stream<MedScannerResponse> get responseStream => _responseController.stream;

  bool get isConnected => _socket?.connected ?? false;

  void connect(String baseUrl, String token) {
    if (isConnected) return;

    AppLogger.i('Connecting to MedScanner WebSocket: $baseUrl/med-scanner');

    AppLogger.i(token);

    _socket = io.io(
      '$baseUrl/med-scanner',
      io.OptionBuilder()
          .setAuth({'token': token})
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    AppLogger.i('MedScanner Socket: $_socket');

    _socket?.onConnect((_) {
      AppLogger.i('MedScanner WebSocket connected');
    });

    _socket?.onDisconnect((_) {
      AppLogger.i('MedScanner WebSocket disconnected');
    });

    _socket?.on('response', (data) {
      AppLogger.i('MedScanner Response: $data');
      try {
        // Data should be a JSON string from the server
        final Map<String, dynamic> jsonMap =
            data is String ? jsonDecode(data) : data;
        final response = MedScannerResponse.fromJson(jsonMap);
        _responseController.add(response);
      } catch (e) {
        AppLogger.e('Failed to parse MedScanner response: $e');
      }
    });

    _socket?.onError((error) {
      AppLogger.e('MedScanner WebSocket error: $error');
    });

    _socket?.connect();
  }

  void sendFrame(Uint8List jpegBytes) {
    if (!isConnected) return;
    // Client emits 'frame' event containing a binary buffer
    _socket?.emit('frame', {'buf': jpegBytes});
  }

  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
    AppLogger.i('MedScanner Socket connection disposed');
  }

  void dispose() {
    disconnect();
    _responseController.close();
  }
}
