import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:schoolshare/Models/content.dart';
import 'dart:async';
import 'dart:convert';

// Ganti URL ini dengan alamat WebSocket server Laravel Anda.
const String _websocketUrl = 'ws://0.0.0.0:8080/app/qzucgq9c2bbmqg3kloza';

class RealtimeService extends GetxService {
  WebSocketChannel? _channel;
  final RxBool isConnected = false.obs;

  // Gunakan StreamController untuk memancarkan event ke listeners
  final StreamController<Map<String, dynamic>> _eventController =
      StreamController<Map<String, dynamic>>.broadcast();

  // Getter untuk stream yang akan diakses oleh HomeController
  Stream<Map<String, dynamic>> get eventStream => _eventController.stream;

  @override
  void onInit() {
    super.onInit();
    connectWebSocket();
  }

  void connectWebSocket() async {
    try {
      _channel = WebSocketChannel.connect(Uri.parse(_websocketUrl));
      isConnected(true);
      print('WebSocket connected');

      // Dengarkan pesan yang masuk dari server
      _channel!.stream.listen(
        (data) {
          // Asumsikan data adalah JSON dari event Laravel
          final eventData = json.decode(data);
          // Tambahkan event ke stream
          _eventController.add(eventData);
        },
        onDone: () {
          isConnected(false);
          print('WebSocket disconnected. Reconnecting...');
          // Coba terhubung kembali setelah beberapa saat
          Future.delayed(const Duration(seconds: 5), connectWebSocket);
        },
        onError: (error) {
          print('WebSocket error: $error');
          isConnected(false);
          _eventController.addError('WebSocket error: $error');
        },
        cancelOnError: true,
      );
    } catch (e) {
      print('Could not connect to WebSocket: $e');
      isConnected(false);
    }
  }

  @override
  void onClose() {
    _channel?.sink.close();
    _eventController.close();
    super.onClose();
  }
}
