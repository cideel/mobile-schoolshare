import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';


class Notif extends StatelessWidget {
  const Notif({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: ScreenUtilInit(
      designSize: Size(375, 854),
      builder: (context, child) => Scaffold(
        body: Center(child: Text("notif"),),
      ),
    )
    ,);
  }
}