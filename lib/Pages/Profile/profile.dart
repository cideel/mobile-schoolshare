import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Pages/Profile/profileTab.dart';
import 'package:schoolshare/Pages/Profile/researchTab.dart';
import 'package:schoolshare/Pages/Profile/statsTab.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: ScreenUtilInit(
        designSize: Size(375, 854),
        builder: (context, child) => DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: AppColor.bgColor,
            body: Column(
              children: [
                Padding(padding: EdgeInsets.symmetric(vertical: 50.h)),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    width: 1.sw,
                    height: 250.h,
                    decoration: BoxDecoration(color: AppColor.bgColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColor.bgColor,
                              borderRadius: BorderRadius.circular(100.r)),
                          height: 80.h,
                          width: 80.w,
                          child: CircleAvatar(
                            backgroundColor: AppColor.componentColor,
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: AppColor.bgColor,
                              size: 50,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 10.h)),
                        Text(
                          "Johan Liebert",
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 10.h)),
                        RichText(
                          softWrap: true,
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Magister',
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.black,
                                    fontSize: 16),
                              ),
                              TextSpan(
                                text: ' | ',
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                  
                                    color: Colors.black,
                                    fontSize: 16),
                              ),
                              TextSpan(
                                text:
                                    'Guru di Academy Research Hextech di Piltover',
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.black,
                                    fontSize: 16),
                              ),
                              TextSpan(
                                text: ' | ',
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.black,
                                    
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TabBar(
                  indicatorColor: AppColor.componentColor,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,

                  tabs: const [
                    Tab(text: "Profil"),
                    Tab(text: "Riset"),
                    Tab(text: "Status"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ProfileTab(),
                      ResearchTab(),
                      StatsTab()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
