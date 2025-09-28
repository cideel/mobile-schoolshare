import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScreenUtilInit(
        designSize: Size(375, 854),
        builder: (context, child) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            title: Text(
              "Pengaturan",
              style: TextStyle(fontSize: 15.sp),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 20.w),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 100.h,
                    width: 100.w,
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/example-profile.jpg'),
                      backgroundColor: AppColor.componentColor,
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10.h)),
                  Text(
                    textAlign: TextAlign.center,
                    "Ratandi Ahmad Fauzan",
                    maxLines: 3,
                    softWrap: true,
                    style: AppTextStyle.titleLarge.copyWith(fontSize: 18.sp),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    softWrap: true,
                    "SMA Negeri 1 Tebing Tinggi",
                    style: AppTextStyle.subtitle,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 35.h)),
                  ListTile(
                    leading: Icon(Icons.person_rounded),
                    title: Text(
                      "Edit Profil",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.8,
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications_rounded),
                    title: Text(
                      "Notifikasi",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.8,
                  ),
                  ListTile(
                    leading: Icon(Icons.settings_rounded),
                    title: Text(
                      "Pengaturan",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.8,
                  ),
                  ListTile(
                    leading: Icon(Icons.star_rate_rounded),
                    title: Text(
                      "Rate",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.8,
                  ),
                  ListTile(
                    leading: Icon(Icons.email_rounded),
                    title: Text(
                      "Kontak kami",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.8,
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text(
                      "Keluar",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
