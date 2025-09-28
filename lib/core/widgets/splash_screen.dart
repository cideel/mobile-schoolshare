// lib/core/widgets/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/app/routes/app_routes.dart';
import 'package:schoolshare/core/utils/storage_utils.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    final token = await StorageUtils.getToken();

    if (token != null && token.isNotEmpty) {
      final bool hasExpired = JwtDecoder.isExpired(token);

      if (hasExpired) {
        print('✅ Token sudah expired. Melakukan logout otomatis.');
        await StorageUtils.clearToken();
        Get.offAllNamed(Routes.LOGIN);
      } else {
        print('✅ Token masih valid. Lanjut ke Home.');
        Get.offAllNamed(Routes.HOME);
      }
    } else {
      // Kalau tidak ada token → ke LOGIN
      print('❌ Tidak ada token tersimpan. Lanjut ke Login.');
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Header(),
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      decoration: BoxDecoration(color: AppColor.componentColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "SchoolShare",
            style: TextStyle(
              fontFamily: 'Shipori', // Pastikan font ini ada
              color: AppColor.bgColor,
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
