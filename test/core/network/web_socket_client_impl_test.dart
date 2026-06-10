import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:ntentan/core/network/web_socket_client_impl.dart';

void main() {
  late WebSocketClientImpl webSocketClient;
  HttpServer? server;
  String? url;

  setUp(() async {
    webSocketClient = WebSocketClientImpl();

    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    url = 'ws://127.0.0.1:${server!.port}';

    server!.listen((HttpRequest request) async {
      if (WebSocketTransformer.isUpgradeRequest(request)) {
        final webSocket = await WebSocketTransformer.upgrade(request);
        webSocket.listen((data) {
          // echo back
          webSocket.add(data);
        });
      }
    });
  });

  tearDown(() async {
    webSocketClient.disconnect();
    await Future.delayed(const Duration(milliseconds: 100));
    await server?.close();
  });

  group('WebSocketClientImpl', () {
    test('should connect and set isConnected to true', () async {
      final expectation = expectLater(
        webSocketClient.stream,
        emits('connected'),
      );

      webSocketClient.connect(url!);

      await expectation;

      expect(webSocketClient.isConnected, isTrue);
    });

    test('should send and receive data correctly', () async {
      final expectation = expectLater(
        webSocketClient.stream,
        emitsInOrder(['connected', 'hello_world']),
      );

      webSocketClient.connect(url!);

      // Give it a tiny bit to connect
      await Future.delayed(const Duration(milliseconds: 100));
      webSocketClient.send('hello_world');

      await expectation;
    });

    test('should handle disconnect correctly', () async {
      final connectExpectation = expectLater(
        webSocketClient.stream,
        emits('connected'),
      );
      webSocketClient.connect(url!);
      await connectExpectation;

      final disconnectExpectation = expectLater(
        webSocketClient.stream,
        emits('disconnected'),
      );
      webSocketClient.disconnect();
      await disconnectExpectation;

      expect(webSocketClient.isConnected, isFalse);
    });
  });
}
