import 'dart:async';
import 'package:ntentan/core/constants/logger.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'web_socket_client.dart';

class WebSocketClientImpl implements WebSocketClient {
  WebSocketChannel? _channel;
  final StreamController<dynamic> _streamController =
      StreamController<dynamic>.broadcast();
  Timer? _reconnectionTimer;
  bool _isConnected = false;
  String? _lastUrl;

  @override
  Stream<dynamic> get stream => _streamController.stream;

  @override
  bool get isConnected => _isConnected;

  @override
  void connect(String url) {
    _lastUrl = url;
    _disconnect();
    _connect(url);
  }

  void _connect(String url) {
    try {
      _channel = IOWebSocketChannel.connect(Uri.parse(url));
      _isConnected = true;
      _streamController.add('connected');
      _channel?.stream.listen(
        (data) {
          AppLogger.i('WebSocket stream data: $data');
          _streamController.add(data);
        },
        onDone: () {
          _isConnected = false;
          _streamController.add('disconnected');
          _reconnect();
        },
        onError: (error) {
          _isConnected = false;
          _streamController.addError('Connection error: $error');
          _streamController.add('disconnected');
          _reconnect();
        },
      );
    } catch (e) {
      _isConnected = false;
      _streamController.addError('Connection failed: $e');
      _streamController.add('disconnected');
      _reconnect();
    }
  }

  void _reconnect() {
    if (_lastUrl != null) {
      _reconnectionTimer?.cancel();
      _reconnectionTimer = Timer(const Duration(seconds: 5), () {
        _connect(_lastUrl!);
      });
    }
  }

  @override
  void send(dynamic data) {
    if (_isConnected && _channel != null) {
      _channel!.sink.add(data);
    }
  }

  @override
  void disconnect() {
    _lastUrl = null;
    _disconnect();
    _streamController.add('disconnected');
  }

  void _disconnect() {
    _reconnectionTimer?.cancel();
    _channel?.sink.close();
    _isConnected = false;
  }
}
