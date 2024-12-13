import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';

class StatsTab extends ConsumerWidget {
  const StatsTab({super.key});

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.symmetric(vertical: 10.h)),
                  Text(
                    "Overview",
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10.h)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InfoBox(
                        score: "7,6",
                        title: "RI Score",
                        onInfoPressed: () {},
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 10.w)),
                      InfoBox(
                        score: "1000",
                        title: "Dibaca",
                        onInfoPressed: () {},
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10.h)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InfoBox(
                        score: "69",
                        title: "Rekomendasi",
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 10.w)),
                      InfoBox(
                        score: "12",
                        title: "Sitasi",
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10.h)),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Icon(Icons.trending_up,color: AppColor.componentColor,),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 5.w)),
                      Text("Lihat laporan status mingguan",style: TextStyle(color: AppColor.componentColor),)
                    ],),
                    height: 45.h,
                    width: 1.sw,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.componentColor)),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5.w)),
                
                  Divider(
                color: Colors.grey,thickness: 0.5,
              )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  final String score;
  final String title;
  final VoidCallback? onInfoPressed;

  const InfoBox({
    Key? key,
    required this.score,
    required this.title,
    this.onInfoPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      width: 157.5.w,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 133, 129, 129),
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              score,
              maxLines: 1,
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 17.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                if (onInfoPressed != null)
                  IconButton(
                    onPressed: onInfoPressed,
                    icon: Icon(Icons.info_outline),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
