// lib/core/services/websocket_services.dart
import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

// Ganti nilai-nilai placeholder ini dengan nilai Anda yang sebenarnya dari .env
const String _reverbHost = '192.168.1.4';
const int _reverbPort = 8080;
const String _reverbAppId = '206142'; // REVERB_APP_ID Anda
const String _reverbAppKey = 'qzucgq9c2bbmqg3kloza';

class WebSocketService {
  WebSocketChannel? _channel;

  // StreamController untuk mengelola data yang sudah diparse (hanya event yang relevan)
  final StreamController<Map<String, dynamic>> _contentStreamController =
      StreamController.broadcast();

  Stream<Map<String, dynamic>> get contentStream =>
      _contentStreamController.stream;

  // StreamSubscription untuk mendengarkan data mentah dari WebSocket
  StreamSubscription? _socketSubscription;

  // Metode untuk menginisialisasi koneksi WebSocket murni
  void initEcho() {
    // 1. Buat URL koneksi Pusher-compatible yang diharapkan Reverb:
    // Format: ws://HOST:PORT/app/APP_ID?protocol=7&client=dart&version=1.0.0
    final uri = Uri.parse(
        'ws://$_reverbHost:$_reverbPort/app/$_reverbAppId?protocol=7&client=dart&version=1.0.0&key=$_reverbAppKey');

    try {
      // 2. Buka koneksi WebSocket
      _channel = WebSocketChannel.connect(uri);

      print('I/flutter: Attempting to connect to Reverb: $uri');

      // 3. Pasang listener untuk data mentah
      _socketSubscription = _channel!.stream.listen(
        _handleIncomingData,
        onError: (error) => print('I/flutter: WebSocket Error: $error'),
        onDone: () => print('I/flutter: WebSocket Disconnected'),
      );

      // 4. Kirim command untuk SUBSCRIBE ke channel publik di sini jika diperlukan
      // (Bisa juga dipanggil di startContentListener)
    } catch (e) {
      print('I/flutter: WebSocket Initialization Failed: $e');
    }
  }

  // Metode untuk memproses data mentah dari WebSocket (Protokol Pusher)
  void _handleIncomingData(dynamic data) {
    if (data is! String) return;

    try {
      final message = json.decode(data);
      final String eventName = message['event'] ?? '';

      // print('I/flutter: Raw Pusher Event: $eventName');

      switch (eventName) {
        case 'pusher:connection_established':
          print('I/flutter: Reverb Connection Established!');
          // Lakukan subscribe channel setelah koneksi berhasil
          // startContentListener();
          break;

        case 'pusher:error':
          print('I/flutter: Pusher Error: ${message['data']}');
          break;

        case 'App\\Events\\ContentCreated': // Ganti dengan nama event Anda
          // Ini adalah event kustom dari Laravel yang Anda siarkan
          final Map<String, dynamic> eventData =
              json.decode(message['data'])['data'];
          _contentStreamController.add(eventData);
          print('I/flutter: ContentCreated Event Received!');
          break;

        // Anda harus menambahkan case untuk semua event kustom Laravel di sini

        default:
          // Abaikan event internal Pusher/Reverb yang lain (ping/pong)
          break;
      }
    } catch (e) {
      print('I/flutter: Error parsing WebSocket data: $e');
    }
  }

  // Metode untuk mengirim command SUBSCRIBE ke Reverb
  void startContentListener() {
    const channelName = 'public-content';
    const eventName = 'App\\Events\\ContentCreated';

    // 1. Kirim command subscribe untuk channel publik
    final subscribeCommand = {
      "event": "pusher:subscribe",
      "data": {
        "auth": null, // Gunakan auth key jika ini channel private/presence
        "channel": channelName
      }
    };

    // 2. Cek status channel dan kirim command
    if (_channel != null && _channel!.closeCode == null) {
      _channel!.sink.add(json.encode(subscribeCommand));
      print('I/flutter: Subscribing to $channelName');
    } else {
      print('I/flutter: Cannot subscribe, WebSocket not connected.');
    }

    // Catatan: Listener event 'ContentCreated' sudah dihandle di _handleIncomingData
  }

  void disconnect() {
    _socketSubscription?.cancel();
    _contentStreamController.close();
    _channel?.sink.close();
    print('I/flutter: WebSocket Service Disconnected.');
  }
}

final webSocketService = WebSocketService();
