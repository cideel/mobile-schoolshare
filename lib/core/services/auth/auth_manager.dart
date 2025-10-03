import 'dart:async';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:schoolshare/app/routes/app_routes.dart';
import 'package:schoolshare/core/utils/storage_utils.dart';

class AuthManager {
  static final AuthManager _instance = AuthManager._internal();

  factory AuthManager() => _instance;

  AuthManager._internal();

  Timer? _timer;

  /// Mulai monitoring token
  void startTokenMonitoring() {
    _timer?.cancel(); // pastikan tidak ada timer sebelumnya
    _timer = Timer.periodic(const Duration(seconds: 5), (_) async {
      await _checkToken();
    });
  }

  /// Hentikan monitoring token
  void stopTokenMonitoring() {
    _timer?.cancel();
  }

  /// Cek token, jika expired langsung logout
  Future<void> _checkToken() async {
    final token = await StorageUtils.getToken();
    if (token == null || token.isEmpty) return;

    final expired = JwtDecoder.isExpired(token);
    if (expired) {
      print("❌ Token expired, logout otomatis.");
      await StorageUtils.clearToken();
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
