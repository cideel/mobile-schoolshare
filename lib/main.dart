import 'package:flutter/material.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Pages/login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:schoolshare/Pages/Profile/profile.dart';
import 'package:schoolshare/Pages/register.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:schoolshare/Pages/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Pastikan binding diinisialisasi terlebih dahulu
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Hanya potrait atas
  ]).then((_) {
    runApp(ProviderScope(child: ScreenUtilInit(
      designSize: Size(375, 854),
        builder: (context, child) => MyApp(),
    )));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.componentColor),
        useMaterial3: true,
      ),
      home: Profile(),
    );
  }
}
