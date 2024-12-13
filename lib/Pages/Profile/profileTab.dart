import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: ScreenUtilInit(
        designSize: Size(375, 854),
        builder: (context, child) => Scaffold(
            body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: ListView(
            children: [
              Text(
                "Afiliasi",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10.h)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/images/example-logo-sma.png',
                      fit: BoxFit.fill,
                    ),
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.r)),
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 10.w)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nama SEKOLAH AFILIASI
                        Text(
                          "Academy Research Hextech",
                          maxLines: 3,
                          textAlign: TextAlign.start,
                          softWrap: true,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 8.h)),
                        Text(
                          "Lokasi",
                          maxLines: 3,
                          textAlign: TextAlign.start,
                          softWrap: true,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14.sp),
                        ),
                        // Nama kota daerah/alamat/ sesuai kebutuhan
                        Text(
                          softWrap: true,
                          "Kota Banjarnegara Raya",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Roboto"),
                        ),

                        Padding(padding: EdgeInsets.symmetric(vertical: 8.h)),
                        Text(
                          "Departemen",
                          maxLines: 3,
                          textAlign: TextAlign.start,
                          softWrap: true,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14.sp),
                        ),
                        //  nama departemen jika ada
                        Text(
                          softWrap: true,
                          "Departemen Riset dan Penelitian Guru Biologi Banjarnegara",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Roboto"),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 8.h)),
                        Text(
                          "Posisi",
                          maxLines: 3,
                          textAlign: TextAlign.start,
                          softWrap: true,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14.sp),
                        ),
                        //  nama departemen jika ada
                        Text(
                          softWrap: true,
                          "Guru Biologi",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Roboto"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10.h)),
              Divider(
                color: Colors.grey,thickness: 0.5,
              )
            ],
          ),
        )),
      ),
    );
  }
}
