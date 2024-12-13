import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';

class ResearchTab extends ConsumerWidget {
  const ResearchTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: ScreenUtilInit(
        designSize: Size(375, 854),
        builder: (context, child) => Scaffold(
            body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              // JIKA DATA MASIH KOSONG
              Padding(padding: EdgeInsets.symmetric(vertical: 20.h)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      "assets/images/icon-add.png",
                      fit: BoxFit.contain,
                      color: Colors.grey,
                    ),
                    height: 70.h,
                    width: 70.w,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10.h)),
                  Text(
                    maxLines: 1,
                    "Masih kosong untuk saat ini",
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10.h)),
                  Text(
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    "Yuk, tambahkan penelitianmu! Biar rekomendasimu makin keren dan kamu makin mudah dikenal di antara rekan-rekanmu!",
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10.h)),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(1.sw, 45.h),
                          backgroundColor: AppColor.componentColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r))),
                      onPressed: () {},
                      child: Text(
                        "Tambahkan penelitian baru",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
